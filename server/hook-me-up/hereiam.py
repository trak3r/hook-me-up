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
    template_values = {
	  'path': os.path.join(os.path.dirname(__file__), 'hooker.html'),
      'hookers': hookers,
      }
    path = os.path.join(os.path.dirname(__file__), 'hookers.html')
    self.response.out.write(template.render(path, template_values))	

class TestForm(webapp.RequestHandler):
  def get(self):
    path = os.path.join(os.path.dirname(__file__), 'testform.html')
    self.response.out.write(template.render(path, {}))	

application = webapp.WSGIApplication(
                                     [('/', TestForm),
                                     ('/hereiam', HereIAm)],
                                     debug=True)

def main():
  run_wsgi_app(application)

if __name__ == "__main__":
  main()