# Begin Metafile <a name="begin-metafile"></a>

### Parameters

| Name       | Type                                        | Description       |
| ---------- | ------------------------------------------- | ----------------- |
| Identifier | [Fixed String](../../types.md#fixed-string) | Not standardized. |

The **Begin Metafile** element is the first element of a metafile,
and marks the beginning of a CGM metafile.
The element must occur exactly once in a metafile.

The _Identifier_ parameter is available for use by metafile generators
and interpreters in a manner that is not further standardized.

# End Metafile <a name="end-metafile"></a>

### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
|      |      |             |

The **End Metafile** element is the last element of a metafile,
and must occur exactly once in a metafile.
