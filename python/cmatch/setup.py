from distutils.core import setup
from Cython.Build import cythonize

setup(
    name='cmatch',
    ext_modules=cythonize(["cmatch.pyx"]), requires=['Cython']
)
