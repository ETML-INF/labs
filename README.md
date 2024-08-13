# ETML-INF labs
source : https://github.com/googlecodelabs/tools

## Version de claat
```shell
claat version
1.0.4-2019-06-28T21:14:15Z-9ad41c6
```

## Codelabs only
Attention, la dernière release fonctionne avec les surveys et vidéo mais pas tous les iframe alors que la version sur le MASTER ne fonctionne pas pour les surveys
``` bash
cd codelabs
claat export --prefix "https://labs.section-inf.ch/elements" *.md
claat serve
```

## Entire site
Warning: With node compatible with node-sass (<=20)
``` bash
npm install
gulp serve
go to http://localhost:12345/
```

## Generate final site
``` bash
gulp dist
```

