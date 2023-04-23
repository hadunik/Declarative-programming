module Paths_AnGeo (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,2,2] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/hadoop/.cabal/bin"
libdir     = "/home/hadoop/.cabal/lib/x86_64-linux-ghc-7.10.3/AnGeo-0.1.2.2-GSd5102Jr1rDcddFxF3bKx"
datadir    = "/home/hadoop/.cabal/share/x86_64-linux-ghc-7.10.3/AnGeo-0.1.2.2"
libexecdir = "/home/hadoop/.cabal/libexec"
sysconfdir = "/home/hadoop/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "AnGeo_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "AnGeo_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "AnGeo_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "AnGeo_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "AnGeo_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
