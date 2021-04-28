library(tidyverse)
library(coronavirus)
library(bbplot2)
library(grDevices)

deaths <- refresh_coronavirus_jhu() %>%
  filter(grepl("Russ", location)) %>%
  filter(data_type == "deaths_new") %>%
  filter(date >= as.Date("2020-03-01"))

deaths_plot <- 
  deaths %>%
  ggplot() +
  geom_line(aes(x = date, y = value), size = 1, color = "#990000") +
  geom_hline(yintercept = 0, size = 1, color = "#333333") +
  bbc_style() +
  labs(
    title = "Количество смертей от Covid-19\nв России по данным оперштаба"
  ) + 
  theme(
    panel.grid.major.y = element_line(size = .3, color = "#dddddd"),
    panel.grid.major.x = element_line(size = .3, color = "#dddddd")
  ) +
  scale_x_date(labels = c(
    "1 апреля 2020",
    "",
    "1 октября 2020",
    "",
    "1 апреля 2021"
  ), breaks = c(
    as.Date("2020-04-01", origin='1970-01-01'),
    as.Date("2020-07-01", origin='1970-01-01'),
    as.Date("2020-10-01", origin='1970-01-01'),
    as.Date("2021-01-01", origin='1970-01-01'),
    as.Date("2021-04-01", origin='1970-01-01')
  ))

finalise_plot(
  plot_name = deaths_plot,
  save_filepath = "charts/deaths.png",
  source_name = "Источник: Университет Джонса Хопкинса"
)

cairo_pdf("pdf/deaths.pdf", width = 670/72, height = 480/72)
print(deaths_plot)
dev.off()