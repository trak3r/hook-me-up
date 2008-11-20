import os
import cgi

from google.appengine.ext import db
from google.appengine.ext import webapp
from google.appengine.ext.webapp import template
from google.appengine.ext.webapp.util import run_wsgi_app

class Hooker(db.Model):
  phone = db.IntegerProperty()
  name = db.StringProperty()
  age = db.IntegerProperty()
  gender = db.StringProperty()
  longitude = db.FloatProperty()
  latitude = db.FloatProperty()
  date = db.DateTimeProperty(auto_now_add=True)

class HereIAm(webapp.RequestHandler):
  def post(self):
    freshmeat = Hooker()
    freshmeat.phone = int(self.request.get('phone'))
    freshmeat.name = self.request.get('name')
    freshmeat.age = int(self.request.get('age'))
    freshmeat.gender = self.request.get('gender')
    freshmeat.longitude = float(self.request.get('longitude'))
    freshmeat.latitude = float(self.request.get('latitude'))
    freshmeat.put()
    hookers = Hooker.gql("ORDER BY date DESC LIMIT 10")
    for hooker in hookers:
      if freshmeat.phone != hooker.phone:
	    template_values = {
	      'hooker': hooker,
	      }
	    path = os.path.join(os.path.dirname(__file__), 'hooker.html')
	    self.response.out.write(template.render(path, template_values))	

class TestForm(webapp.RequestHandler):
  def get(self):
    self.response.out.write("""
          <html>
          <body>
          <form action="/hereiam" method="post">
          <div><input name="phone" value="9548168827" /></div>
          <div><input name="name" value="Ted" /></div>
          <div><input name="age" value="36" /></div>
          <div><input name="gender" value="m" /></div>
          <div><input name="longitude" value="-80.4038" /></div>
          <div><input name="latitude" value="26.1353"/></div>
            <div><input type="submit" value="Hook Me Up"></div>
          </form>
          </body>
          </html>
          """)

application = webapp.WSGIApplication(
                                     [('/', TestForm),
                                     ('/hereiam', HereIAm)],
                                     debug=True)

def main():
  run_wsgi_app(application)

if __name__ == "__main__":
  main()