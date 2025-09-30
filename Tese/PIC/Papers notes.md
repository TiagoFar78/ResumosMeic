# Papers to check

- [x] Automatic rule verification for digital building permits, [WebPage](https://rep-dspace.uminho.pt/entities/publication/81118d54-96bc-4747-9d88-785c53738c7d), [Saved](Papers/Automatic%20Rule%20Verification%20for%20Digital%20Building%20Permits.pdf)
- [ ] [A rule-based semantic approach for automated regulatory compliance in the construction sector](https://www.sciencedirect.com/science/article/abs/pii/S0957417415001360)
- [ ] [Model Validation for Automated Building Code Compliance Checking](https://ascelibrary.org/doi/abs/10.1061/9780784483961.067)
- [ ] _Maybe trash_ [Automated Information Transformation for Automated Regulatory Compliance Checking in Construction](https://ascelibrary.org/doi/abs/10.1061/(ASCE)CP.1943-5487.0000427)
- [ ] [Towards Automated Compliance Checking in the Construction Industry](https://link.springer.com/chapter/10.1007/978-3-642-40285-2_32)

# Automatic rule verification for digital building permits

This focuses on proposing a hybrid workflow approach for the digitalization of building permit processes, emphasizing automated extraction and validation of information within Building Information Models (BIM). It combines explicit information defined by modelers and implicit data derived from relationships among BIM elements, aiming to improve the reliability and efficiency of the permit process in Portugal.

It identifies challenges in aligning BIM model semantics with regulatory definitions and highlights the need for automated quality validation of submitted models. It proposes a hybrid validation workflow using Python and the IfcOpenShell library to automate processes traditionally performed by municipal technicians. The core contribution is the implementation of a system that extracts both explicitly provided data and implicitly derived spatial relationships, validating them against local regulations.

Verifica as propriedades:
- Área do Lote
- Área de implantação
- Área de Logradouro
- Área de impermeabilização
- Área Bruta de Construção

The work proves that hybrid automatic validation saves time and increases the certainty of information correctness compared to traditional visual/manual methods. The system detects errors and helps reconcile explicit and derived data, offering valuable tools for standardizing and automating digital building permit processes. However, limitations were recognized—including difficulties handling complex or curved geometries and the need for ongoing refinement of algorithms and standardization frameworks. The author stresses that dual validation remains essential during the transition to fully automated digital permits to avoid over-reliance on either explicit model data or automated extraction alone.
