# CROP_DB

A database of **crops** and their **cultivars** and **rootstocks**. The crops are then paired to the **WCA Crop List**
and the ICC 1.1 **classifications**.

Combination of:

- Fruit and Nut Cultivars Database ([FNC][FNC])
- World Census of Agriculture ([WCA][WCA]) Crop List of the Food and Agriculture Organization of the United Nations
- Indicative Crop Classification ([ICC][ICC]) 1.1

## Usage

Can download the release db file and import or run the `psql` cli tool from the root of this directory. To initialize
this db, run:

```
\i sql/seeds/setup.sql
```

_Note: This repo uses PostgreSQL. Should be easy to modify for any other dialect if you wish._

### Export

For releases, we use the `release` branch. On update, we can export with `pg_dump`, replace the `crop_db.sql` file and
push as a new release. Specifically for `psycopg2` import compatibility, we also dump using inserts.

```bash
pg_dump -U username -d database --schema=crop --no-owner --no-acl > crop_db.sql
pg_dump -U username -d database --schema=crop --no-owner --no-acl --inserts > crop_db__inserts.sql
```

#### Classification structure:

```
ICC Group
├─ ICC Class
│  ├─ ICC Subclass
│  │  ├─ ICC Order
│  │  │  │
└──┴──┴──┴─ WCA Crop
      ┌────────┴────────┐
FNC Cultivar     FNC Rootstock
```

#### Possible additional data sources:

- [rootstocks.info](https://www.rootstocks.info/rootstocks)
- [U.S. Department of Agriculture's PLANTS Database](https://plants.usda.gov/downloads)
- [USDA National Plant Germplasm System](https://npgsweb.ars-grin.gov/gringlobal/search)
- [RosBREED](https://www.rosbreed.org/breeding/cherry)
- [Sweet Cherry Genome-Enabled Breeding Values XplorR](https://jpiaskowski.shinyapps.io/cherry_gebv_xplorr/)

<!-- Links -->

[FNC]: https://www.fruitandnutlist.org/data/ajax-response
[WCA]: https://www.fao.org/statistics/caliper/classifications/wca
[ICC]: https://www.fao.org/statistics/caliper/classifications/icc
