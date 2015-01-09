import urllib2
import urllib

class LatestRomUtil:

	def __init__(self, device):
		self.changeDevice(device)

	def __getPage(self, url, retRedirUrl = False):
		try:
			bOpener = urllib2.build_opener()
			bOpener.addheaders = [("User-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36")]
			pResponse = bOpener.open(url)
			if retRedirUrl == True:
				return pResponse.geturl()
			else:
				pageData = pResponse.read()
				return pageData
		except Exception:
			return ""

	def changeDevice(self, device):
		self.device = device.strip().lower()

	def dlSuperSU(self):
		getUrl = self.__getPage("http://download.chainfire.eu/supersu", True)
		latestUrl = getUrl + "?retrieve_file=1"
		return latestUrl


# below is example usage
romUtil = LatestRomUtil("tf300t")

print "Downloading to su.zip"
urllib.urlretrieve (romUtil.dlSuperSU(), "su.zip")
