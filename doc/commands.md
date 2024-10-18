# CGM command reference

This document provides basic information about the commands specified in the CGM standard.

## Element Classes

0. [Delimiter Elements](#delimiter-elements)
1. [Metafile Descriptor Elements](#metafile-descriptor-elements)
2. [Picture Descriptor Elements](#picture-descriptor-elements)
3. [Control Elements](#control-elements)
4. [Graphical Primitive Elements](#graphical-primitive-elements)
5. [Attribute Elements](#attribute-elements)
6. [Escape Elements](#escape-elements)
7. [External Elements](#external-elements)
8. [Segment Elements](#segment-elements)
9. [Application Structure Elements](#application-structure-elements)

# 0: Delimiter Elements <a name="delimiter-elements"></a>

Delimiter elements are used to mark the beginning and end of various parts of the drawing.

0. [No Operation](#no-operation)
1. [Begin Metafile](#begin-metafile)
2. [End Metafile](#end-metafile)
3. [Begin Picture](#begin-picture)
4. [End Picture Bodd](#end-picture-body)
5. [End Picture](#end-picture)
6. [Begin Segment](#begin-segment)
7. [End Segment](#end-segment)
8. [Begin Figure](#begin-figure)
9. [End Figure](#end-figure)
10. Unused
11. Unused
12. Unused
13. [Begin Protection Region](#begin-protection-region)
14. [End Protection Region](#end-protection-region)
15. [Begin Compound Line](#begin-compound-line)
16. [End Compound Line](#end-compound-line)
17. [Begin Compound Text Path](#begin-compound-text-path)
18. [End Compound Text Path](#end-compound-text-path)
19. [Begin Tile Array](#begin-tile-array)
20. [End Tile Array](#end-tile-array)
21. [Begin Application Structure](#begin-application-structure)
22. [Begin Application Structure Body](#begin-application-structure-body)
23. [End Application Structure](#end-application-structure)

### (0,0): No Operation <a name="no-operation"></a>

This element is used to pad the metafile to a word boundary.

### (0,1): Begin Metafile <a name="begin-metafile"></a>

This element is used to mark the beginning of a CGM metafile.

### (0,2): End Metafile <a name="end-metafile"></a>

This element is used to mark the end of a CGM metafile.

### (0,3): Begin Picture <a name="begin-picture"></a>

This element is used to mark the beginning of a picture.

### (0,4): End Picture Body <a name="end-picture-body"></a>

This element is used to mark the end of the body of a picture.

### (0,5): End Picture <a name="end-picture"></a>

This element is used to mark the end of a picture.

### (0,6): Begin Segment <a name="begin-segment"></a>

This element is used to mark the beginning of a segment.

### (0,7): End Segment <a name="end-segment"></a>

This element is used to mark the end of a segment.

### (0,8): Begin Figure <a name="begin-figure"></a>

This element is used to mark the beginning of a figure.

### (0,9): End Figure <a name="end-figure"></a>

This element is used to mark the end of a figure.

### (0,13): Begin Protection Region <a name="begin-protection-region"></a>

This element is used to mark the beginning of a protection region.

### (0,14): End Protection Region <a name="end-protection-region"></a>

This element is used to mark the end of a protection region.

### (0,15): Begin Compound Line <a name="begin-compound-line"></a>

This element is used to mark the beginning of a compound line.

### (0,16): End Compound Line <a name="end-compound-line"></a>

This element is used to mark the end of a compound line.

### (0,17): Begin Compound Text Path <a name="begin-compound-text-path"></a>

This element is used to mark the beginning of a compound text path.

### (0,18): End Compound Text Path <a name="end-compound-text-path"></a>

This element is used to mark the end of a compound text path.

### (0,19): Begin Tile Array <a name="begin-tile-array"></a>

This element is used to mark the beginning of a tile array.

### (0,20): End Tile Array <a name="end-tile-array"></a>

This element is used to mark the end of a tile array.

### (0,21): Begin Application Structure <a name="begin-application-structure"></a>

This element is used to mark the beginning of an application structure.

### (0,22): Begin Application Structure Body <a name="begin-application-structure-body"></a>

This element is used to mark the beginning of the body of an application structure.

### (0,23): End Application Structure <a name="end-application-structure"></a>

This element is used to mark the end of an application structure.

# 1: Metafile Descriptor Elements <a name="metafile-descriptor-elements"></a>

Metafile descriptor elements are used to describe the metafile.

0. Unused
1. [Metafile Version](#metafile-version)
2. [Metafile Description](#metafile-description)
3. [VDC Type](#vdc-type)
4. [Integer Precision](#integer-precision)
5. [Real Precision](#real-precision)
6. [Index Precision](#index-precision)
7. [Color Precision](#color-precision)
8. [Color Index Precision](#color-index-precision)
9. [Maximum Color Index](#maximum-color-index)
10. [Color Value Extent](#color-value-extent)
11. [Metafile Element List](#metafile-element-list)
12. [Metafile Default Replacement](#metafile-default-replacement)
13. [Font List](#font-list)
14. [Character Set List](#character-set-list)
15. [Character Coding Announcer](#character-coding-announcer)
16. [Name Precision](#name-precision)
17. [Maximum VDC Extent](#maximum-vdc-extent)
18. [Segment Priority Extent](#segment-priority-extent)
19. [Color Model](#color-model)
20. [Color Calibration](#color-calibration)
21. [Font Properties](#font-properties)
22. [Glyph Mapping](#glyph-mapping)
23. [Symbol Library List](#symbol-library-list)
24. [Picture Directory](#picture-directory)

### (1,1): Metafile Version <a name="metafile-version"></a>

This element is used to specify the version of the CGM standard that the metafile conforms to.

### (1,2): Metafile Description <a name="metafile-description"></a>

This element is used to specify a description of the metafile.

### (1,3): VDC Type <a name="vdc-type"></a>

This element is used to specify the type of the VDC (Virtual Device Coordinate) system.

### (1,4): Integer Precision <a name="integer-precision"></a>

This element is used to specify the precision of integer values in the metafile.

### (1,5): Real Precision <a name="real-precision"></a>

This element is used to specify the precision of real values in the metafile.

### (1,6): Index Precision <a name="index-precision"></a>

This element is used to specify the precision of index values in the metafile.

### (1,7): Color Precision <a name="color-precision"></a>

This element is used to specify the precision of color values in the metafile.

### (1,8): Color Index Precision <a name="color-index-precision"></a>

This element is used to specify the precision of color index values in the metafile.

### (1,9): Maximum Color Index <a name="maximum-color-index"></a>

This element is used to specify the maximum color index value in the metafile.

### (1,10): Color Value Extent <a name="color-value-extent"></a>

This element is used to specify the extent of color values in the metafile.

### (1,11): Metafile Element List <a name="metafile-element-list"></a>

This element is used to specify the list of elements contained in the metafile.

### (1,12): Metafile Default Replacement <a name="metafile-default-replacement"></a>

This element is used to specify the default replacement for missing elements in the metafile.

### (1,13): Font List <a name="font-list"></a>

This element is used to specify the list of fonts used in the metafile.

### (1,14): Character Set List <a name="character-set-list"></a>

This element is used to specify the list of character sets used in the metafile.

### (1,15): Character Coding Announcer <a name="character-coding-announcer"></a>

This element is used to specify the character coding used in the metafile.

### (1,16): Name Precision <a name="name-precision"></a>

This element is used to specify the precision of names in the metafile.

### (1,17): Maximum VDC Extent <a name="maximum-vdc-extent"></a>

This element is used to specify the maximum VDC extent in the metafile.

### (1,18): Segment Priority Extent <a name="segment-priority-extent"></a>

This element is used to specify the extent of segment priorities in the metafile.

### (1,19): Color Model <a name="color-model"></a>

This element is used to specify the color model used in the metafile.

### (1,20): Color Calibration <a name="color-calibration"></a>

This element is used to specify the color calibration used in the metafile.

### (1,21): Font Properties <a name="font-properties"></a>

This element is used to specify the properties of fonts used in the metafile.

### (1,22): Glyph Mapping <a name="glyph-mapping"></a>

This element is used to specify the mapping of glyphs to characters in the metafile.

### (1,23): Symbol Library List <a name="symbol-library-list"></a>

This element is used to specify the list of symbol libraries used in the metafile.

### (1,24): Picture Directory <a name="picture-directory"></a>

This element is used to specify the directory of pictures in the metafile.

# 2: Picture Descriptor Elements <a name="picture-descriptor-elements"></a>

Picture descriptor elements are used to describe the picture.

0. Unused
1. [Scaling Mode](#scaling-mode)
2. [Color Selection Mode](#color-selection-mode)
3. [Line Width Specification Mode](#line-width-specification-mode)
4. [Marker Size Specification Mode](#marker-size-specification-mode)
5. [Edge Width Specification Mode](#edge-width-specification-mode)
6. [VDC Extent](#vdc-extent)
7. [Background Color](#background-color)
8. [Device Viewport](#device-viewport)
9. [Device Viewport Specification Mode](#device-viewport-specification-mode)
10. [Device Viewport Mapping](#device-viewport-mapping)
11. [Line Representation](#line-representation)
12. [Marker Representation](#marker-representation)
13. [Text Representation](#text-representation)
14. [Fill Representation](#fill-representation)
15. [Edge Representation](#edge-representation)
16. [Interior Style Specification Mode](#interior-style-specification-mode)
17. [Line and Edge Type Definition](#line-and-edge-type-definition)
18. [Hatch Style Definition](#hatch-style-definition)
19. [Geometric Pattern Definition](#geometric-pattern-definition)
20. [Application Structure Directory](#application-structure-directory)

### (2,1): Scaling Mode <a name="scaling-mode"></a>

This element is used to specify the scaling mode used in the picture.

### (2,2): Color Selection Mode <a name="color-selection-mode"></a>

This element is used to specify the color selection mode used in the picture.

### (2,3): Line Width Specification Mode <a name="line-width-specification-mode"></a>

This element is used to specify the line width specification mode used in the picture.

### (2,4): Marker Size Specification Mode <a name="marker-size-specification-mode"></a>

This element is used to specify the marker size specification mode used in the picture.

### (2,5): Edge Width Specification Mode <a name="edge-width-specification-mode"></a>

This element is used to specify the edge width specification mode used in the picture.

### (2,6): VDC Extent <a name="vdc-extent"></a>

This element is used to specify the VDC extent of the picture.

### (2,7): Background Color <a name="background-color"></a>

This element is used to specify the background color of the picture.

### (2,8): Device Viewport <a name="device-viewport"></a>

This element is used to specify the device viewport of the picture.

### (2,9): Device Viewport Specification Mode <a name="device-viewport-specification-mode"></a>

This element is used to specify the device viewport specification mode used in the picture.

### (2,10): Device Viewport Mapping <a name="device-viewport-mapping"></a>

This element is used to specify the device viewport mapping used in the picture.

### (2,11): Line Representation <a name="line-representation"></a>

This element is used to specify the representation of lines in the picture.

### (2,12): Marker Representation <a name="marker-representation"></a>

This element is used to specify the representation of markers in the picture.

### (2,13): Text Representation <a name="text-representation"></a>

This element is used to specify the representation of text in the picture.

### (2,14): Fill Representation <a name="fill-representation"></a>

This element is used to specify the representation of fills in the picture.

### (2,15): Edge Representation <a name="edge-representation"></a>

This element is used to specify the representation of edges in the picture.

### (2,16): Interior Style Specification Mode <a name="interior-style-specification-mode"></a>

This element is used to specify the interior style specification mode used in the picture.

### (2,17): Line and Edge Type Definition <a name="line-and-edge-type-definition"></a>

This element is used to specify the definition of line and edge types in the picture.

### (2,18): Hatch Style Definition <a name="hatch-style-definition"></a>

This element is used to specify the definition of hatch styles in the picture.

### (2,19): Geometric Pattern Definition <a name="geometric-pattern-definition"></a>

This element is used to specify the definition of geometric patterns in the picture.

### (2,20): Application Structure Directory <a name="application-structure-directory"></a>

This element is used to specify the directory of application structures in the picture.

# 3: Control Elements <a name="control-elements"></a>

Control elements are used to control the behavior of the CGM interpreter.

0. Unused
1. [VDC Integer Precision](#vdc-integer-precision)
2. [VDC Real Precision](#vdc-real-precision)
3. [Auxiliary Color](#auxiliary-color)
4. [Transparency](#transparency)
5. [Clip Rectangle](#clip-rectangle)
6. [Clip Indicator](#clip-indicator)
7. [Line Clipping Mode](#line-clipping-mode)
8. [Marker Clipping Mode](#marker-clipping-mode)
9. [Edge Clipping Mode](#edge-clipping-mode)
10. [New Region](#new-region)
11. [Save Primitive Context](#save-primitive-context)
12. [Restore Primitive Context](#restore-primitive-context)
13. Unused
14. Unused
15. Unused
16. Unused
17. [Protection Region Indicator](#protection-region-indicator)
18. [Generalized Text Path Mode](#generalized-text-path-mode)
19. [Mitre Limit](#mitre-limit)
20. [Transparenct Cell Color](#transparent-cell-color)

### (3,1): VDC Integer Precision <a name="vdc-integer-precision"></a>

This element is used to specify the precision of integer values in the VDC.

### (3,2): VDC Real Precision <a name="vdc-real-precision"></a>

This element is used to specify the precision of real values in the VDC.

### (3,3): Auxiliary Color <a name="auxiliary-color"></a>

This element is used to specify the auxiliary color.

### (3,4): Transparency <a name="transparency"></a>

This element is used to specify the transparency.

### (3,5): Clip Rectangle <a name="clip-rectangle"></a>

This element is used to specify the clip rectangle.

### (3,6): Clip Indicator <a name="clip-indicator"></a>

This element is used to specify the clip indicator.

### (3,7): Line Clipping Mode <a name="line-clipping-mode"></a>

This element is used to specify the line clipping mode.

### (3,8): Marker Clipping Mode <a name="marker-clipping-mode"></a>

This element is used to specify the marker clipping mode.

### (3,9): Edge Clipping Mode <a name="edge-clipping-mode"></a>

This element is used to specify the edge clipping mode.

### (3,10): New Region <a name="new-region"></a>

This element is used to specify a new region.

### (3,11): Save Primitive Context <a name="save-primitive-context"></a>

This element is used to save the primitive context.

### (3,12): Restore Primitive Context <a name="restore-primitive-context"></a>

This element is used to restore the primitive context.

### (3,17): Protection Region Indicator <a name="protection-region-indicator"></a>

This element is used to specify the protection region indicator.

### (3,18): Generalized Text Path Mode <a name="generalized-text-path-mode"></a>

This element is used to specify the generalized text path mode.

### (3,19): Mitre Limit <a name="mitre-limit"></a>

This element is used to specify the mitre limit.

### (3,20): Transparenct Cell Color <a name="transparent-cell-color"></a>

This element is used to specify the transparency cell color.

# 4: Graphical Primitive Elements <a name="graphical-primitive-elements"></a>

Graphical primitive elements are used to draw graphical primitives.

0. Unused
1. [Polyline](#polyline)
2. [Disjoint Polyline](#disjoint-polyline)
3. [Polymarker](#polymarker)
4. [Text](#text)
5. [Restricted Text](#restricted-text)
6. [Append Text](#append-text)
7. [Polygon](#polygon)
8. [Polygon Set](#polygon-set)
9. [Cell Array](#cell-array)
10. [Generalized Drawing Primitive](#generalized-drawing-primitive)
11. [Rectangle](#rectangle)
12. [Circle](#circle)
13. [Circular Arc 3-Point](#circular-arc-3-point)
14. [Circular Arc 3-Point Close](#circular-arc-3-point-close)
15. [Circular Arc Center](#circular-arc-center)
16. [Circular Arc Center Close](#circular-arc-center-close)
17. [Ellipse](#ellipse)
18. [Elliptical Arc](#elliptical-arc)
19. [Elliptical Arc Close](#elliptical-arc-close)
20. [Circular Arc Center Reversed](#circular-arc-center-reversed)
21. [Connecting Edge](#connecting-edge)
22. [Hyperbolic Arc](#hyperbolic-arc)
23. [Parabolic Arc](#parabolic-arc)
24. [Non-Uniform B-Spline](#non-uniform-b-spline)
25. [Non-Uniform Rational B-Spline](#non-uniform-rational-b-spline)
26. [Polybezier](#polybezier)
27. [Polysymbol](#polysymbol)
28. [Bitonal Tile](#bitonal-tile)
29. [Tile](#tile)

### (4,1): Polyline <a name="polyline"></a>

This element is used to draw a polyline.

### (4,2): Disjoint Polyline <a name="disjoint-polyline"></a>

This element is used to draw a disjoint polyline.

### (4,3): Polymarker <a name="polymarker"></a>

This element is used to draw a polymarker.

### (4,4): Text <a name="text"></a>

This element is used to draw text.

### (4,5): Restricted Text <a name="restricted-text"></a>

This element is used to draw restricted text.

### (4,6): Append Text <a name="append-text"></a>

This element is used to append text.

### (4,7): Polygon <a name="polygon"></a>

This element is used to draw a polygon.

### (4,8): Polygon Set <a name="polygon-set"></a>

This element is used to draw a polygon set.

### (4,9): Cell Array <a name="cell-array"></a>

This element is used to draw a cell array.

### (4,10): Generalized Drawing Primitive <a name="generalized-drawing-primitive"></a>

This element is used to draw a generalized drawing primitive.

### (4,11): Rectangle <a name="rectangle"></a>

This element is used to draw a rectangle.

### (4,12): Circle <a name="circle"></a>

This element is used to draw a circle.

### (4,13): Circular Arc 3-Point <a name="circular-arc-3-point"></a>

This element is used to draw a circular arc defined by three points.

### (4,14): Circular Arc 3-Point Close <a name="circular-arc-3-point-close"></a>

This element is used to draw a closed circular arc defined by three points.

### (4,15): Circular Arc Center <a name="circular-arc-center"></a>

This element is used to draw a circular arc defined by the center and two points.

### (4,16): Circular Arc Center Close <a name="circular-arc-center-close"></a>

This element is used to draw a closed circular arc defined by the center and two points.

### (4,17): Ellipse <a name="ellipse"></a>

This element is used to draw an ellipse.

### (4,18): Elliptical Arc <a name="elliptical-arc"></a>

This element is used to draw an elliptical arc.

### (4,19): Elliptical Arc Close <a name="elliptical-arc-close"></a>

This element is used to draw a closed elliptical arc.

### (4,20): Circular Arc Center Reversed <a name="circular-arc-center-reversed"></a>

This element is used to draw a circular arc defined by the center and two points in reverse order.

### (4,21): Connecting Edge <a name="connecting-edge"></a>

This element is used to draw a connecting edge.

### (4,22): Hyperbolic Arc <a name="hyperbolic-arc"></a>

This element is used to draw a hyperbolic arc.

### (4,23): Parabolic Arc <a name="parabolic-arc"></a>

This element is used to draw a parabolic arc.

### (4,24): Non-Uniform B-Spline <a name="non-uniform-b-spline"></a>

This element is used to draw a non-uniform B-spline.

### (4,25): Non-Uniform Rational B-Spline <a name="non-uniform-rational-b-spline"></a>

This element is used to draw a non-uniform rational B-spline.

### (4,26): Polybezier <a name="polybezier"></a>

This element is used to draw a polybezier.

### (4,27): Polysymbol <a name="polysymbol"></a>

This element is used to draw a polysymbol.

### (4,28): Bitonal Tile <a name="bitonal-tile"></a>

This element is used to draw a bitonal tile.

### (4,29): Tile <a name="tile"></a>

This element is used to draw a tile.

# 5: Attribute Elements <a name="attribute-elements"></a>

Attribute elements are used to set attributes used by graphical primitives.
