# Title 1
## Title 2
### Title 3

## How to create a table

The code follows a layered model. A layer can depend on lower layers, but not
on upper layers.

| Python packages      | Layer type      |
|----------------------|-----------------|
| api, cli             | Presentation    |
| repository           | Business logic  |
| auth                 | Business logic  |
| accessdb, cognito    | Data access     |
| entities             | Business logic  |