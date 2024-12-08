#import scrapy


#class ImdbSpiderSpider(scrapy.Spider):
   # name = "imdb_spider"
    #allowed_domains = ["www.imdb.com"]
    #start_urls = ["https://www.imdb.com/chart/top/?ref_=nv_mv_250"]
    #user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"

    #def start_requests(self):
        # Pass the custom user agent in the headers of the request
     #   for url in self.start_urls:
      #      yield scrapy.Request(url, headers={'User-Agent': self.user_agent}, callback=self.parse)


    #def parse(self, response):
     #   movies = response.css('main div div section div div div ul li')
      #  for movie in movies:
       #     yield {
        #        'title': movie.css('div div div div a h3 ::text').getall(),
         #       'year': movie.css('div div span ::text').getall(),
          #      'ratings': movie.css('div div div span div span::text').getall()
           # }

import scrapy

class ImdbSpiderSpider(scrapy.Spider):
    name = "imdb_spider"
    allowed_domains = ["www.imdb.com"]
    start_urls = ["https://www.imdb.com/chart/top/?ref_=nv_mv_250"]
    user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"

    def start_requests(self):
        for url in self.start_urls:
            yield scrapy.Request(url, headers={'User-Agent': self.user_agent}, callback=self.parse)

    def parse(self, response):
        movies = response.css('main div div section div div div ul li')
        for movie in movies:
            title = movie.css('div div div div a h3::text').getall()
            year = movie.css('div div span::text').getall()
            rating = movie.css('div div div span div span::text').getall()
            print(title, year, rating)
          

            # Handle potential empty lists or missing data
            if title and year and rating:
                yield {
                    'title': title,
                    'year': year,
                    'rating': rating  
                }
                self.logger.warning(f"Missing data for movie: {title}, {year}, {rating}")
            else:
                self.logger.warning(f"Missing data for movie: {title}, {year}, {rating}")