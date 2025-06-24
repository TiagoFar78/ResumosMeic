# Inheritance Testing

### Liskov substitution principle

Classes have contracts that are invariants, pre-conditions for method arguments and post-conditions for method return.

Liskov substitution principle (LSP) have some rules to keep the contract of a subclass compatible with the contract of the superclass:
- Subclass may keep or weaken the precondition in the overridden methods.
- Subclass may keep or strengthen the postcondition in the overridden methods.
- Subclass may keep or strengthen the class invariant.
- Subclass may keep or strengthen state invariants.

### Inheritance-related bugs

- Fat Interface bug: A subclass inherits methods that are inappropriate or irrelevant.
  - Being SquareWindow as a subclass of RectangularWindow, RectangularWindow.resize(x,y) is inherited by SquareWindow, but is doesn't make sense. SquareWindow should have its own resize method with only one argument.
- Incorrect initialization: Superclass initialization is omitted or incorrect.
- Missing override.
- Inadvertent binding: Incorrect bindings due to misunderstood name-scoping rules.
  - Same instance variable name used in superclass and subclass.
- Naked Access: Direct access to superclass fields from the subclass code.

### Flattening class scope

Flattened class makes all inherited features explicit. Example:

```java
public class A {
    public void a1() {...}
    public void a2() {...}
    private void a3() {...}
}

public class B extends A {
    public void a2() {...}
    public void b4() {...}
    public void b5() {...}
    private void b6() {...}
}

public class C extends B {
    public void a2() {...}
    public void b5() {...}
    public void c7() {...}
}
```

- Class A:
  - Class scope: a1, a2, a3
  - Flattened scope: same
- Subclass B extends A
  - Class scope: B.a2, b4, b5, b6
  - Flattened scope:
    - a1, B.a2, b4, b5 and b6
- Subclass C
  - C.a2/b5 - overrides B.a2/b5
  - c7 - specialization
  - Class scope: C.a2, C.b5, c7
  - Flattened scope:
    - a1, b4, C.a2, C.b5, c7

| | Extension | Overriding | Specialization |
| ----------------------- | --------- | ---------- | -------------- |
| Prudent extent of retesting of this method in subclass | Minimal $^{1,2}$ | Full | Full |
| Reuse superclass method tests | Yes | Probably $^3$ | N/A |
| Develop new subclass method tests | Maybe $^2$ | Yes | Yes |
| Should this method be included in the class scope testing? | No | Yes $^4$ | Yes $^4$ |
| Should this method be included in the flattened class scope testing? | Yes $^4$ | Yes $^4$ | Yes $^4$ | 

1. Method scope tests do not need to be repeated.
2. New tests are needed when inherited features use locally defined features
3. Superclass tests are reusable if the superclass and subclasses comply with the LSP
4. Individual method tests are insufficient to test method interactions

We should inherit the tests from the superclass to help us testing the subclass.

### For testing at flattened class scope

- Polymorphic Server Test - Design a reusable test suite for a LSPcompliant polymorphic server hierarchy.
- Modal Hierarchy Test - Design a test suite for a hierarchy of modal classes.
- Non-modal classes - Apply non-modal class test at flattened class scope.

## Polymorphic Server Test

### Fault model

- Any of the fault classes described [earlier](#inheritance-related-bugs)
- Faults related to an overridden method
- Faults in clients are not the target of this pattern

### Strategy

- Build a test suite for each class in the hierarchy that checks for conformance with LSP.
- Each polymorphic method should be exercised in its defining class and all subclasses that inherit it.
- Test suite focus on contract of polymorphic methods.
- Must be possible to reuse it with instances of subclasses.
- Parametrize it with a reference to an object of the CUT.
- If subclass does not conform to LSP, the base class test suite may reveal this fault.

### Example

Contract of Account: deposit(val) -> pre: 0 < val <= 100

```java
public class TestAccount {
    
    protected Account a;
    
    @BeforeMethod
    protected void setUp() {
        a = new Account();
    }

    @Test
    public final void testMaxDeposit() {
        a.deposit(100);
        assertEquals(a.getBalance(), 100);
    }
    ...
}
```

Contract of SavingsAccount:
- setInterest(interest) pre: 0 < interest <= 0.1
- applyInterest() -> post: bal = bal*(1 + interest)

```java
public class TestSavingAccount extends TestAccount {

    protected SavingsAccount sa;
    
    @BeforeMethod
    protected void setUp() {
        sa = new SavingsAccount();
        a = sa;
    }
    
    @Test
    public final void testMaxInterest() {
        sa.deposit(100);
        sa.setInterest(0.1);
        sa.applyInterest();
        assertEquals(sa.getBalance(), 110);
    }
    ...
}
```

### Entry and Exit Criteria

Entry Criteria:
- An alpha-omega cycle is developed from the subclass up.
- All superclasses pass their test suites.

Exit Criteria: Every superclass method is exercised in the context of every subclass once.

### Consequences

- Establishes high confidence in the reusability of polymorphic servers.
- Reveal faults that prevent LSP conformance and may reveal other inheritance-related faults.
- It requires the design and implementation of test drivers that parallel the polymorphic structure of the CUT.

## Modal Hierarchy Test

The intent is to design a flattened class scope test suite for a hierarchy of modal classes.

### Strategy

Test model is the same as that employed for Modal Class Test. However, the state machine must reflect the states and events of the flattened class. 
- If subclass is LSP-compliant with superclass then run superclass test suite as regression test.
- If not LSP-compliant, then the value of executing the superclass test suite is not clear.

### Flattened class

There are four ways to generate the flattened class.

1. The subclass can partition one or more states of superclass. Some states of subclass are part of a state of the superclass.

<img src="Imagens/6 - Modal Hierarchy Test 1.png">

2. The subclass defines its own state behavior orthogonal to the state behavior of the superclass.

<img src="Imagens/6 - Modal Hierarchy Test 2.png">

3. No modal behavior defined in subclass. Run superclass test suite as regression. May have to develop modal class scope for flattened subclass.
4. The subclass defines its own modal behavior, but does not preserve the modal behavior of the superclass. Still has to develop modal class scope for flattened subclass. Execution of superclass test suite may result in anomaly.

## Log String

Often one needs to test that the sequence in which methods are called is correct. To check that have each method append to a log string when it is called.

The problem with this is that it requires changes to the implementation.

## Accessing private fields

Using reflection, one can actually call private methods and access private attributes! For example:

```java
class A {
  private String sayHello(String name) {
    return "Hello, " + name;
  }
}
```

```java
import java.lang.reflect.Method;

public void testPrivateMethod {
  A test = new A();
  Method[] methods = test.getClass().getDeclaredMethods();
  for (int i = 0; i < methods.length; ++i) {
    if (methods[i].getName().equals("sayHello")) {
      Object params[] = {"Richard"};
      methods[i].setAccessible(true);
      Object ret = methods[i].invoke(test, params);
      System.out.println(ret);
    }
  }
}
```

## Crash Test Dummy

Sometimes, it is quite hard to create the situation that will cause the error.

For example an error writing to a file because the file system is full.

```java
class Example {
  private FileOutputSystem fos;
  // ...

  public Example(FileOutputSystem fos) {
    this.fos = fos;
  }

  public boolean writeData()  throws IOException {
    try {
      this.fos.write(_data);
    }
    catch (IOException ioe) { ... }
  }
}
```

```java
class FullSystem extends FileOutputSystem {
  public FullSystem(String path) {
    super(path);
  }

  public boolean write(String str) throws IOException {
    throw new IOException();
  }
  // similar for remaining methods
}
```

```java
@Test 
public void testFileSystemFull() {
  Example f = new Example(new FullSystem("foo"));
  try {
    // ...
    f.writeData(str);
    ...
  } catch (IOException e) {
    fail();
  }
}
```

## Abstract Class Test

The intent is to develop a test implementation of a test suite for an abstract class interface.

### Strategy

1. Develop a subclass, which implements all of the superclass's abstract methods. Implementing a subclass is part of the test.
2. Apply method and class scope test pattern for abstract class. Develop test cases for abstract methods and for concrete methods.
3. Test subclass as flattened. May need to develop additional test cases for implemented abstract methods in subclass.

Separated test suites for abstract and subclass.

### Example

Consider a statistics application that uses the Strategy design pattern.

```java
public interface StatPak {
  public void reset();
  public void addValue(double x);
  public double getN();
  public double getMean();
  public double getStdDev();
}
```

Test suite for abstract class is composed of tests defining the functionality of the interface belong in the abstract test class.

```java
public abstract TestStatPak extends TestCase {
  private StatPak statPak;

  // final to prevent overriding
  public final setUp() throws Exception {
    statPak = createStatPak();
    assertNotNull(statPak);
  }

  // Factory Method.
  public abstract StatPak createStatPak();

  public final void testMean() {
    statPak.addValue(2.0); statPak.addValue(3.0);
    statPak.addValue(4.0); statPak.addValue(2.0); statPak.addValue(4.0);
    assertEquals("Mean value should be 3.0", 3.0,statPak.getMean());
  }

  public final void testStdDev() { ... }
  ...
}
```

Test suite for concrete class is composed of tests specific to an implementation belong in a concrete test class. Test this class at flattened scope.

```java
public class TestSuperSlowStatPak extends TestStatPak {
  public StatPak createStatPak() {
    return new SuperSlowStatPak();
  }
  ...
}
```