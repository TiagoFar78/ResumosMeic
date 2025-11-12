# Papers to check

- [x] Automatic rule verification for digital building permits, [WebPage](https://rep-dspace.uminho.pt/entities/publication/81118d54-96bc-4747-9d88-785c53738c7d), [Saved](Papers/Automatic%20Rule%20Verification%20for%20Digital%20Building%20Permits.pdf)
- [x] A rule-based semantic approach for automated regulatory compliance in the construction sector [WebPage](https://pure.aston.ac.uk/ws/files/29320900/Rule_based_semantic_approach.pdf), [Saved](Papers/rule-based%20semantic%20approach%20for%20automated%20regulatory%20compliance%20in%20the%20construction%20sector.pdf)
- [x] BIM-Based Method for the Verification of Building Code Compliance, [WebPage](https://www.mdpi.com/2571-5577/5/4/64), [Saved](Papers/BIM-Based%20Method%20for%20the%20Verification%20of%20Building%20Code%20Compliance.pdf)
- [x] A Vision for Automated Building Code Compliance Checking by Unifying Hybrid Knowledge Graphs and Large Language Models, [WebPage](https://www.researchgate.net/publication/395297094_A_Vision_for_Automated_Building_Code_Compliance_Checking_by_Unifying_Hybrid_Knowledge_Graphs_and_Large_Language_Models), [Saved](Papers/A%20Vision%20for%20Automated%20Building%20Code%20Compliance%20Checking%20by%20Unifying%20Hybrid%20Knowledge%20Graphs%20and%20Large%20Language%20Models.pdf)
- [x] Automated Code Compliance Checking: A computational workflow for verifying model, parameter and regulatory compliance, [WebPage](https://www.academia.edu/101918035/Automated_Code_Compliance_Checking_A_computational_workflow_for_verifying_model_parameter_and_regulatory_compliance), [Saved](Papers/Automated%20Code%20Compliance%20Checking%20A%20computational%20workflow%20for%20verifying%20model,%20parameter%20and%20regulatory%20compliance.pdf)
- [x] Automated code compliance checking research based on BIM and knowledge graph, [WebPage](https://www.nature.com/articles/s41598-023-34342-1), [Saved](Papers/Automated%20code%20compliance%20checking%20research%20based%20on%20BIM%20and%20knowledge%20graph.pdf)
- [x] Establishment of Database for Automated Building Codes Compliance Checking in the Pre-Design Phase, [WebPage](https://papers.cumincad.org/data/works/att/ecaade2022_136.pdf), [Saved](Papers/Establishment%20of%20Database%20for%20Automated%20Building%20Codes%20Compliance%20Checking%20in%20the%20Pre-Design%20Phase.pdf)
- [ ] Automatic Rule-Based Checking for the Approval of Building Architectural Designs of Airport Passenger Terminals based on BIM, [WebPage](https://papers.cumincad.org/data/works/att/ecaadesigradi2019_613.pdf), [Saved](Papers/Automatic%20Rule-Based%20Checking%20for%20the%20Approval%20of%20Building%20Architectural%20Designs%20of%20Airport%20Passenger%20Terminals%20based%20on%20BIM.pdf)
- [ ] _Não encontrei_ Past, Present and Future: From Evaluation to Project Validation
- [ ] _Não encontrei_ Rule-based compliance checking and generative design for building interiors using BIM
- [ ] _Não encontrei_ Automated floorplan generation in architectural design: A review of methods and applications, [WebPage](https://www.sciencedirect.com/science/article/pii/S0926580522002588)
- [ ] _Não encontrei_ Automatic rule-based checking of building designs
- [ ] Integrating Regulatory Compliance In AI-Assisted Architectural Design, [WebPage](https://datahub.hku.hk/articles/conference_contribution/2_Integrating_Regulatory_Compliance_In_AI-Assisted_Architectural_Design/29349179?file=55632086), [Saved](Papers/Integrating%20Regulatory%20Compliance%20In%20AI-Assisted%20Architectural%20Design.pdf)
- [ ] [Model Validation for Automated Building Code Compliance Checking](https://ascelibrary.org/doi/abs/10.1061/9780784483961.067)
- [ ] [Towards Automated Compliance Checking in the Construction Industry](https://link.springer.com/chapter/10.1007/978-3-642-40285-2_32)
- [ ] _Maybe trash_ [Automated Information Transformation for Automated Regulatory Compliance Checking in Construction](https://ascelibrary.org/doi/abs/10.1061/(ASCE)CP.1943-5487.0000427)
- [ ] _Maybe Trash_ The Ups and Downs of Automated Code Checking Software, [WebPage](https://www.construction-physics.com/p/the-ups-and-downs-of-automated-code)

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


# A rule-based semantic approach for automated regulatory compliance in the construction sector

The paper addresses the complexity and technical challenge of automating regulatory compliance in industries like construction, where regulations and data formats are diverse, complex, and often inconsistent. Existing compliance solutions are difficult to maintain, lack flexibility, and typically require significant software development. The authors propose a novel methodology that leverages semantic technologies to bridge the gap between domain regulations, the target domain (e.g., construction), and the data formats used for compliance checking, allowing specialists to specify and update regulations directly.

The approach is centered on a semantic framework that embodies three interconnected contexts. The semantics of the target domain (core domain ontology). The semantics of specific regulations being automated (regulation ontology). The semantics of the data format being checked (data format ontology).

Key elements include :
- Enhanced regulatory documents with semantic metadata using a methodology based on RASE (Requirement, Application, Selection, Exception) tags, plus extensions for scoring and decision modeling.
- Extraction of formalized, computable rules from regulation documents, mapped to existing data standards like IFCs (Industry Foundation Classes).
- Separate interfaces and tools for regulation experts (to specify rules and metadata) and data format experts (to map regulatory concepts to data schemas).
- Automatic conversion of regulatory logic into SWRL (Semantic Web Rule Language) rules for execution by a rule engine.
- An open, extensible architecture allowing domain experts to modify, update, and maintain the compliance checking system often without need for developer intervention.

The methodology was validated through a comprehensive case study in the UK construction sector, automated for regulations like BREEAM and the Code for Sustainable Homes, and tested on real building models. Results show that the approach enables the accurate, efficient automation of complex regulatory compliance checks, aligning with manual assessment outcomes. It separates domain and IT expertise, allowing domain specialists to update regulations as these change, by simply modifying metadata and mappings. The system facilitates reuse across multiple regulation systems and data formats, improving scalability and maintainability. The open, semantic-based architecture offers clear advantages over closed commercial systems currently in use.

# BIM-Based Method for the Verification of Building Code Compliance

This work demonstrates that every measurable characteristic of a BIM model can be automatically evaluated and processed using Dynamo, allowing for flexible and robust creation of quantitative and qualitative compliance routines.

It focuses on automating compliance with urban master plan regulations such as restrictions on building bulk and site usage. The Dynamo routine checks key site and building parameters, including the maximum allowed gross floor area relative to the site (utilisation coefficient), the maximum percentage of site covered by buildings (occupancy rate), and the minimum required area of permeable ground to support soil infiltration. It also assesses geometric restrictions like the number of floors, total building height, and the required minimum distances (offsets) from property lines at the front, back, and sides of a building, as well as the steepest allowed slopes for pedestrian and vehicle ramps.

It also checks the some Building Code Requirements. Such as, Minimum Room Area (by room type, like hall, bathroom, kitchen, etc), Minimum Window Area and Minimum Ceiling Height.

# A Vision for Automated Building Code Compliance Checking by Unifying Hybrid Knowledge Graphs and Large Language Models

Hybrid knowledge graphs combine structured data (like databases or BIM models) with unstructured information (like text from regulations or documents) in a single network. This integration allows systems to represent both precise relationships between entities and the broader semantic meaning of text.

This paper proposes using hybrid knowledge graphs and LLMs to automate building code compliance checking in the Architecture, Engineering, and Construction industry.

On the positive side, transforming IFC files into knowledge graphs is a strong concept. It organizes complex building data semantically, making it easier to link architecture models with legal regulations. _Probably worth giving it a try._

However, the rest of the system is less efficient in practice. Adding a new regulation requires significant data preprocessing—segmenting and structuring text before it can be used. Moreover, each rule must be queried separately, meaning that the framework doesn’t handle full regulation sets seamlessly. Since the LLMs are mainly used to generate Graph Query Language (GQL) queries, a fully automated system could theoretically be built without LLMs if all queries were manually prepared in advance.

The authors claim scalability, but their demonstration focuses only on fire protection requirements, producing a graph with just 14 nodes. Additionally, relying on AI models introduces the risk of errors.

# Automated Code Compliance Checking: A computational workflow for verifying model, parameter and regulatory compliance

The paper presents a transparent and customizable computational workflow to automatically verify building models for code compliance, focusing on checking doors against Australian regulations AS1428.1:2021.

To determine whether a door respects the regulation, the researchers built a workflow in Grasshopper integrated with Revit via Rhino.Inside.Revit. The process begins by extracting Revit door parameters such as width, height, and thickness. The script then performs two main checks: model compliance and regulatory compliance. Model compliance ensures that each door’s parameters and geometry match its defined type data, while regulatory compliance involves testing geometric conditions derived from AS1428.1.

As a limitation, the process currently takes about 30 seconds to check 11 doors.

_Information about how they made regulatory compliance can be found on their section "FINALISED ITERATION – REGULATORY AND CODE COMPLIANCE"_

# Automated code compliance checking research based on BIM and knowledge graph

This paper aim is to transform regulatory text into machine-readable formats, enabling computers to perform efficient and accurate compliance checks on building designs. Regulatory codes are processed with Natural Language Processing (NLP) to extract entities, attributes, and relationships, forming a knowledge graph. BIM model data is exported in IFC format, and converted into machine-readable structures (IFCOWL and RDF) to align with the regulatory knowledge graph. The system uses checking rules (implemented via SPARQL queries) to evaluate if BIM model components conform to the regulatory requirements. Then reports are generated automatically.

It covers regulations from:
- Uniform Standards for Civil Building Design
- Code for fire prevention in building design
- Accessibility Design Code
- Fire Prevention Code for Building Interior Decoration Design
- Building Water Supply and Drainage Design Code

It was also able to complete the analysis in short periods of time, less than 10s, and achieve an accuracy above 96%. _Not sure if that is actually good._

# Establishment of Database for Automated Building Codes Compliance Checking in the Pre-Design Phase

The paper proposes a method for automating building code compliance checks in the early stages of architectural design in Korea. The authors develop a process to extract, formalize, and encode natural language requirements from building regulations into a structured, computer-readable database. This enables the use of an authoring tool that provides automatic, real-time legality checks.​

Its current limitations include addressing only simple building compliance factors like size and height. It is also only applied to pre-design phase.
