# Begin Picture

### Parameters

| Name       | Type                                        | Description       |
| ---------- | ------------------------------------------- | ----------------- |
| Identifier | [Fixed String](../../types.md#fixed-string) | Not standardized. |

This is the first element of a picture.

It marks the beginning of a picture descriptor. It forces all
picture descriptor, control and attribute elements which are subject
to default to return to the default values.

The _Identifier_ parameter is available for use by metafile generators
and interpreters in a manner that is not further standardized.

For compatibility with _ISO 2022_, designating and invoking controls
which may occur within the string parameters of [Text](elements/primitive/text.md),
[Append Text](elements/primitive/append-text.md), [Restricted Text](elements/primitive/restricted-text.md),
and [Generalized Drawing Primitive](elements/primitive/generalized-drawing-primitive.md) elements,
the way that **Begin Picture** forces the character set to assume its default value
is as follows:

- **Begin Picture** causes the character set selected by the default value of
  [Character Set Index](elements/attribute/character-set-index.md) attribute to be
  designated as the current _G0_ set and invoked into positions 2/1 through 7/14 of
  the 7-bit or 8-bit code chart.

- **Begin Picture** also designates the character set selected by the default value of
  [Alternate Character Set Index](elements/attribute/alternate-character-set-index.md)
  attribute as the current _G1_ set and also as the current _G2_ set.

# Begin Picture Body

### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
|      |      |             |

This element demarcates the end of the **Picture Descriptor** and the beginning of the body of the picture. It
thus informs the metafile interpreter of the transition from the **Picture Descriptor** to the graphical primitive,
attribute, and control elements that define the picture.

If a new picture begins with a cleared view surface, the initial colour of the view surface is the colour
specified by the [Background Color](../attribute/background-color.md) element,
if that element is present in the **Picture Descriptor**, or
by the default background colour, if the [Background Color](../attribute/background-color.md)
element is not present in the **Picture Descriptor**.

# End Picture

### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
|      |      |             |

This is the last element of a picture.

Only external and escape elements may occur between the **End Picture** and **Begin Picture**,
or between the **End Picture** and **End Metafile** elements.
