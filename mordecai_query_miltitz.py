import warnings
warnings.filterwarnings("ignore")
import spacy

# Load libraries
from mordecai import Geoparser # may take a little to load
from pprint import pprint

# Create geoparser and parse example text
geo = Geoparser(nlp = spacy.load("de_core_news_lg"))
#geo = Geoparser(nlp = spacy.load("en_core_web_sm"))
#geo = Geoparser(nlp = spacy.load("en_core_web_lg"))

with open('miltitz.txt','r') as file:
    myText = file.read()

result = geo.geoparse(myText)

# Print the geoparsed text results
pprint(result)