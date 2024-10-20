# Begin Segment

### Parameters

| Name       | Type                            | Description       |
| ---------- | ------------------------------- | ----------------- |
| Identifier | [Number](../../types.md#number) | Not standardized. |

This is the first element of a segment.

All subsequent elements until the next [End Segment](segment.md#end-segment)
will belong to this segment.

The _Identifier_ parameter is available for use by metafile generators
and interpreters in a manner that is not further standardized.

# End Segment

### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
|      |      |             |

This is the last element of a segment.

Subsequent elements will no longer belong to a segment.
