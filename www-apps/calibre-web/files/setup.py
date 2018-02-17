import os
from setuptools import setup

# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...
def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name = "cps",
    version = "1.0.0",
    author = "Jan B (Janeczku)",
    author_email = "none@none.com",
    description = ("Web app for browsing, reading, and downloading eBooks stored in a Calibre database"),
    license = "GPLv3",
    keywords = "calibre web",
    url = "https://github.com/janeczku/calibre-web",
    packages=['cps'],
    long_description=read('readme.md'),
)

