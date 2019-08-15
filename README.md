# Indian Fuzzy Language
A grammar based fuzz testing language. It is a generic framework, it can be used to fuzz test any
network protocols.

## 1. IFL High Level Design

### 1.1 IFL Inputs
IFL takes XML file as a grammar to PUT (Protocol Under Test). It expects the XML configuration
to explain about each and every fields of a protocol message, with detailed list of valid and
invalid values. It uses this XML configurations to generate a systematic fuzzing messages.

### 1.2 IFL Fuzz Generators
IFL contains various types of Fuzz message generators which are listed below.
    - **Default Value with Zero**: Generates msg with the default value for all the fields of a msg,
    based on the default value specified in XML configuration. And keeps zero if no default value is
    specified.
    - **Default Value with Random**: Same as above, expcept it keeps random values for the field
    which does not contain default value on the XML configuration.
    - **Sample Based**: For generating fuzz message it takes a valid message as input along with
    XML configuration.

## 2. IFL Low Level Design

### 2.1 Protocol Msg Format
IFL retrieves Protocol msg format from XML configuration given as input, and converts to a Tree
data structure to maintain all message fields and its properties. It uses libexpat to parse the XML
configuration file.
