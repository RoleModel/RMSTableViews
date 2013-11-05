#  The Form Descriptor
 
A form descriptor specifies the sections and cells present in the UITableView associated with an **RMSFormViewController** subclass. A form descriptor is structured as an array of section dictionaries. Section dictionaries describe an **RMSFormSection** and contain an array of rows. Each row in a section dictionary's **rows** element consists of a single cell dictionary. Cell dictionaries describe parameters associated with an instance of an **RMSFormCell** subclass. Section dictionaries and cell dictionaries are described in detail below.

## Object Substitution

Certain values specified in a form descriptor can reference objects that are defined outside of the descriptor. References to these external objects are supplied by an **RMSFormViewController** subclass in a object substitution dictionary.

Within the form descriptor itself, the object references are given as colon-prefixed strings. These strings must be present as keys in the object substitution dictionary. If a non-existent key is referenced, an exception will be thrown during cell generation. Not all values in the form descriptor support the use of variable substitution. The values that allow substitution are noted in the discussion that follows. 

## Section Dictionary Keys

`bindVariable`

A string specifiying key to bind to the section. The specified key must reference a key-value coding compliant property on the RMSFormViewController subclass. It would make sense for this key to reference a property of type **id** or **RMSFormSection**.
                
`enabled` *Allows value substitution*

Controls the presence of the section in the table. Can be specified as a either a literal or a colon-prefixed string referencing a substitution object to be evaluated as a boolean. 

`rows`

 An array of cell dictionaries
 
`properties` *Allows substitution for contained values*

A dictionary of key-path/value pairs to be set on the section. The values can be specified as literals or as substitution references.

## Cell Dictionary Keys

`className` 
          
A string specifying the name of the RMSFormCell subclass for the cell.

`bindVariable`

A string specifiying key to bind to the cell. The specified key must reference a key-value coding compliant property on the RMSFormViewController subclass. It would make sense for this key to reference a property of type **id** or **RMSFormCell** or an **RMSFormCell** subclass.

`enabled` *Allows value substitution*

Controls the presence of the cell in the section. Can be specified as a either a literal or a colon-prefixed string referencing a substitution object to be evaluated as a boolean.

`properties` *Allows substitution for contained values*

A dictionary of additional key-paths/value pairs to be set on the cell. The values can be specified as literals or as substitution references.

