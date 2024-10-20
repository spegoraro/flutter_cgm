# Metafile data type definitions

### Color Index <a name="color-index"></a>

Non-negative integer pointer into a table of color values.

### Color Component <a name="color-component"></a>

One component of a direct color value.

### Direct Color <a name="direct-color"></a>

Three-tuple or four-tuple of [Color Component](#color-component) values
(determined by [Color Model](elements/descriptor/color-model.md))
for color definition within one of the supported color models.

### Color <a name="color"></a>

[Color Index](#color-index) if [Color Selection Mode](elements/descriptor/color-selection-mode.md) is `Indexed`;
[Direct Color](#direct-color) if [Color Selection Mode](elements/descriptor/color-selection-mode.md) is `Direct`.

### Enumerated <a name="enumerated"></a>

Set of standardized values. The set is defined by enumerating;
The identifiers that denote the values.

### Integer <a name="integer"></a>

Number with no fractional part.

### Index <a name="index"></a>

Integer pointer into a table of values,
or integer used to select from among a set of enumerated values.

### Point <a name="point"></a>

Two [VDC](#vdc) values representing the _x_ and _y_ coordinates of a point
in _VDC_ space.

### Real <a name="real"></a>

Number with integer and fractional portion, only one of which need exist.

### String <a name="string"></a>

Sequence of characters.

### VDC <a name="vdc"></a>

Single _real_ or _integer_ value (determined by [VDC Type](elements/descriptor/vdc-type.md))
in _VDC_ space.

### Size Specification <a name="size-specification"></a>

_VDC_ if applicable specification mode is **_absolute_**, otherwise _real_.
Size specification applies to such metafile aspects as lien width and marker size.

### Data Record <a name="data-record"></a>

User-defined and otherwise non-standardized record of data that accompanies
elements such as [Application Data](elements/external/application-data.md),
[Escape](elements/escape/escape.md), and
[Generalized Drawing Primitive](elements/primitive/generalized-drawing-primitive.md).

### Name <a name="name"></a>

Identifier for a segment, pick, or context. Realization is integer.
Range is dependent on [Name Precision](elements/descriptor/name-precision.md).

### Viewport Coordinate <a name="viewport-coordinate"></a>

Single real or integer value (determined by [Viewport Type](elements/descriptor/viewport-type.md))

### Viewport Point <a name="viewport-point"></a>

Two [Viewport Coordinate](#viewport-coordinate) values representing the _x_ and _y_ coordinates of a point

### UInt8 <a name="uint8"></a>

Unsigned 8-bit integer.

### UInt16 <a name="uint16"></a>

Unsigned 16-bit integer.

### UInt32 <a name="uint32"></a>

Unsigned 32-bit integer.

### Bitstream <a name="bitstream"></a>

A binary data object, given an encoding-dependent representation in each
of the encodings (part 3, part 4), which consists of a compressed stream of
the binary representations of other CGM datatypes (e.g., colors),
compressed according to one of a number of standardized techniques
defined in this part of this International Standard.

### Structured Data Record <a name="structured-data-record"></a>

A record of data comprised of a list of zero of more members.
Each member is a typed sequence of data elements of the same data type.
A typed sequence contains: a data type indicator, a data count,
and that many items of the indicated type. The type may be _SDR_ itself,
or one of the above data types.

### Fixed String <a name="fixed-string"></a>

Sequence of characters, comprising string parameters of non-graphical text strings,
not subject to character attributes and controls.
