# Papers to check

- [x] Automatic rule verification for digital building permits, [WebPage](https://rep-dspace.uminho.pt/entities/publication/81118d54-96bc-4747-9d88-785c53738c7d), [Saved](Papers/Automatic%20Rule%20Verification%20for%20Digital%20Building%20Permits.pdf)
- [x] A rule-based semantic approach for automated regulatory compliance in the construction sector [WebPage](https://pure.aston.ac.uk/ws/files/29320900/Rule_based_semantic_approach.pdf), [Saved](Papers/rule-based%20semantic%20approach%20for%20automated%20regulatory%20compliance%20in%20the%20construction%20sector.pdf)
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
