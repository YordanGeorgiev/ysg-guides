# Title Heading 1
## Title Heading 2
### Title Heading 3

## How to create a multiline code snippets
```bash
echo "this is a bash code"
```

## How to create a table

The code follows a layered model. A layer can depend on lower layers, but not
on upper layers.

### table 2 columns 
| Component | Layer type      |
|----------------------|-----------------|
| api, cli             | Presentation    |
| repository           | Business logic  |
| auth                 | Business logic  |
| entities             | Business logic  |


### table with 4 columns 
Env| Subnet | CIDR | AZ
--- | --- | :--- | :---:
prd | public | /28 | a
prd | private database | /28 | b
prd | private database | /28 | c
stg | public | /28 | b
stg | private database | /28 | c
tst | public | /28 | a
tst | public | /28 | b
tst | private database | /28 | a
tst | private database | /28 | b
dev | public | 10.7.19.96/27 | a
dev | private | 10.7.97.1/26 | c

