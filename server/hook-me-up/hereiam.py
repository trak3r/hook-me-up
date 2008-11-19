import cgi

from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.ext import db

class Hooker(db.Model):
  name = db.StringProperty()
  age = db.IntegerProperty()
  gender = db.StringProperty()
  longitude = db.FloatProperty()
  latitude = db.FloatProperty()
  date = db.DateTimeProperty(auto_now_add=True)

class Pimp(webapp.RequestHandler):
  def post(self):
    hooker = Hooker()
    hooker.name = self.request.get('name')
#    hooker.age = self.request.get('age')
#    hooker.gender = self.request.get('gender')
#    hooker.longitude = self.request.get('longitude')
#    hooker.latitude = self.request.get('latitude')
    hooker.put()
    self.redirect('/')

class MainPage(webapp.RequestHandler):
  def get(self):
    self.response.out.write('<html><body>')
    self.response.out.write('Hookers...')
    hookers = Hooker.gql("ORDER BY date DESC LIMIT 10")
    for hooker in hookers:
      self.response.out.write('<li>%s</li>' % hooker.name)
    self.response.out.write("""
          <form action="/hereiam" method="post">
            <div><input name="name" /></div>
            <div><input type="submit" value="Hook Me Up"></div>
          </form>""")
    self.response.out.write('</body></html>')

application = webapp.WSGIApplication(
                                     [('/', MainPage),
                                      ('/hereiam', Pimp)],
                                     debug=True)

def main():
  run_wsgi_app(application)

if __name__ == "__main__":
  main()