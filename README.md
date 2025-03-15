# CROP_DB

A database of **crops** and their **cultivars** and **rootstocks** from the FNC. The crops are then paired to the **WCA Crop List**
and the ICC 1.1 **classifications**.

Combination of:

- Fruit and Nut Cultivars Database ([FNC][FNC])
- World Census of Agriculture ([WCA][WCA]) Crop List of the Food and Agriculture Organization of the United Nations
- Indicative Crop Classification ([ICC][ICC]) 1.1

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

<!-- Links -->

[FNC]: https://www.fruitandnutlist.org/data/ajax-response
[WCA]: https://www.fao.org/statistics/caliper/classifications/wca
[ICC]: https://www.fao.org/statistics/caliper/classifications/icc
