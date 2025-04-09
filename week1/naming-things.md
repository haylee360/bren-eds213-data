# Naming things is hard
Haylee Oyler

Part of our capstone includes calculating a spatial statistic called Getis-Ord Gi*. Throughout last quarter, we kept refering to this statistic by different names because we weren't 100% sure what to call it. Eventually, our advisor told us the common practice name it's referred by, which is gi star. At this point, I had already used a number of different abbrevations in our data frames for this stat, so figuring out how to consolidate them in a way that was convention and easy to understand was quite a pain. 

The old names looked like this:
- gi_sim_burd: gi star values for our burdens category
- gi_sim_ind: gi star values for our indicator category
- gi_sim_burd_geoda: gi star values for our burdens category, calculated using geoda
- gi_sim_ind_geoda: gi star values for our indicator category, calculated using geoda

The new names look like this:
- gis_burd
- gis_ind
- gis_burd_geoda
- gis_ind_geoda

I found it helpful to just shorten the column names so it's easier to view. Also, when exporting to a shapefile, the column names get cutoff, so it was somewhat necessary. 