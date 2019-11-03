# CrossAlert

CrossAlert is web application where the Red Cross can easily get an overview of what people are talking about on social media in order 
to be ready to act in a situation of crisis even before police and other authorities have gone public with the information.

## Installation

Install Elixir and Ruby

Run:

```
  # To generate json files of tweets for search terms
  mix dump_red_cross

  # To convert outputted json files to csv
  mix convert_red_cross

  # To generate webpage details from csvs
  ruby generate.rb
``` 

