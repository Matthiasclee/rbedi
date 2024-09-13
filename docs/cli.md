# RBEDI CLI

### Usage
`edi [files] [arguments]`

### Arguments
* `-c "<commands>"`: Run `edi` with preset commands `"<commands>"`. Commands must be semicolon-terminated.
* `--raise-errors`: Don't catch ruby errors

### Commands
* `switch`: Switch control between user and preset command (only applicable when using `-c`)
* `sel`: Show current selection
    * `sel <tx>.<fg>.<ts>.<sg>`: Select tranaction `<tx>`, functional group `<fg>`, transaction set `<ts>`, and segment `<sg>`. *Not all are required*
* `tx`: Transaction
    * `tx list`: List transactions
    * `tx sel`: Show currently selected transaction
        * `tx sel <tx>`: Select transaction `<tx>`
    * `tx desel`: Deselect current transaction
    * `tx load <file>`: Load EDI transaction in `<file>`
    * `tx unload <tx>`: Unload transaction `<tx>`
    * `tx dup <file>`: Duplicate current transaction to `<file>`
    * `tx new <file>`: Create new transaction in `<file>`
    * `tx attr <attr>`: Get value of `<attr>`
        * `tx attr <attr> <val>`: Set value of `<attr>` to `<val>`
        * Valid attributes: see ([Segments > ISA](segments/ISA.md))
    * `tx write`: Save current transaction
* `fg`: Functional Group
    * `fg list`: List functional groups
    * `fg sel`: Show currently selected functional group
        * `fg sel <fg>`: Select functional group `<fg>`
    * `fg desel`: Deselect functional group
    * `fg dup`: Duplicate functional group
        * `fg dup <id>`: Duplicate current functional group, with id `<id>`
    * `fg new`: New functional group
        * `fg new <id>`: New functional group with id `<id>`
    * `fg del`: Delete functional group
    * `fg attr <attr>`: Get value of `<attr>`
        * `fg attr <attr> <val>`: Set value of `<attr>` to `<val>`
        * Valid attributes: see ([Segments > GS](segments/GS.md))
* `ts`: Transaction Set
    * `ts list`: List transaction sets
    * `ts sel`: Show currently selected transaction set
        * `ts sel <ts>`: Select transaction set `<ts>`
    * `ts desel`: Deselect transaction set
    * `ts dup`: Duplicate transaction set
        * `ts dup <id>`: Duplicate current transactip set, with id `<id>`
    * `ts new`: New transaction set
        * `ts new <id>`: New transaction set with id `<id>`
    * `ts del`: Delete transaction set
    * `ts attr <attr>`: Get value of `<attr>`
        * `ts attr <attr> <val>`: Set value of `<attr>` to `<val>`
        * Valid attributes: see ([Segments > ST](segments/ST.md))
* `sg`: Segment
    * `sg list`: List segments
        * `sg list <sg>`: List segment `<sg>`
        * `sg list <1> <2>`: List segments `<1>` through `<2>`
    * `sg fil <type>`: List all segments of type `<type>`
    * `sg search <regex>`: List all segments containing string `<regex>`
    * `sg sel`: Show currently selected segment
        * `sg sel <sg>`: Select segment `<sg>`
    * `sg desel`: Deselect segment
    * `sg dup`: Duplicate segment
        * `sg dup <id>`: Duplicate current segment, with id `<id>`
    * `sg new <type>`: Create new segment of type `<type>`
        * `sg new <type> <id>`: Create new segment of type `<type>` with id `<id>`
    * `sg del`: Delete segment
    * `sg attr <attr|id>`: Get value of attribute `<attr>` or attribute in position `<id>`
        * `sg attr <attr|id> <value>`: Set value of attribute `<attr>` or attribute in position `<id>` to `<value>`
