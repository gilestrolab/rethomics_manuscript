rm(list=ls())
library(ggetho)
library(damr)
library(zeitgebr)

met <- damr::link_dam2_metadata("./metadata.csv", ".")
dt <- load_dam2(met)

summary(dt)
dt[,t := t - days(xmv(baseline_days))]
dt[, moving :=  activity > 0]
dt[, label := interaction(1:.N, genotype), meta=T]
dt

ggetho(dt, aes(y=label, z=moving)) + 
  stat_tile_etho() + 
  stat_ld_annotations(x_limits = c(dt[,min(t)], 0)) +
  stat_ld_annotations(x_limits = c(0, dt[,max(t)]), ld_colours = c("white", "grey"))

# remove dead animals here

ggetho(dt, aes(z=moving), multiplot=2) + 
  stat_tile_etho() +
  facet_wrap(~label) 

# from the overview, we decide to 
dt_ll <- dt[t > days(1)]

ggetho(dt_ll, aes(z=moving/2), multiplot=2) + 
  stat_tile_etho() +
  facet_wrap(~label) 

per_dt <- periodogram(moving, 
						dt_ll, 
						FUN=chi_sq_periodogram, 
						period_range = c(hours(15), hours(32)))
per_dt <- find_peaks(per_dt)

ggperio(per_dt, aes(y = power, peak=peak)) + geom_line() + geom_peak() + facet_wrap(~label) 
