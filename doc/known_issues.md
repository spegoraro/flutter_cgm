# Known Issues

## CGM Core

### Text command

- Doesn't currently offset and scale correctly. It's better than jcgm's implementation, but still not good.
- Doesn't currently apply font style and weight.
- Doesn't currently apply text alignment.

### Elliptical Arc

- Clockwise calculation is wrong (see example `F234R162`)
