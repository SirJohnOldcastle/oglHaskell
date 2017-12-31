module Main where

import Lib
import Graphics.Rendering.OpenGL as GL
import Graphics.UI.GLFW as GLFW
import Control.Monad (forever)
import System.Exit (exitSuccess)

keyPressed :: GLFW.KeyCallback
keyPressed win GLFW.Key'Escape _ GLFW.KeyState'Pressed _ = shutdown win
keyPressed _   _               _ _                     _ = return ()

shutdown :: GLFW.WindowCloseCallback
shutdown win =
  do
    GLFW.destroyWindow win
    GLFW.terminate
    _ <- exitSuccess
    return ()

main :: IO ()
main = do
  GLFW.init
  GLFW.defaultWindowHints
  GLFW.windowHint (GLFW.WindowHint'Samples 4)
  GLFW.windowHint (GLFW.WindowHint'ContextVersionMajor 3)
  GLFW.windowHint (GLFW.WindowHint'ContextVersionMinor 3)
  GLFW.windowHint (GLFW.WindowHint'OpenGLProfile GLFW.OpenGLProfile'Core)
  GLFW.windowHint (GLFW.WindowHint'OpenGLForwardCompat True)
  GLFW.windowHint (GLFW.WindowHint'Resizable False)
  maybeWin <- GLFW.createWindow 1024 768 "Tutorial 01" Nothing Nothing
  case maybeWin of
    Just win -> do
      GLFW.makeContextCurrent (Just win)
      GLFW.setKeyCallback win (Just keyPressed)
      GLFW.setWindowCloseCallback win (Just shutdown)
      forever $ do
        GLFW.swapBuffers win
        GLFW.pollEvents
    Nothing -> putStrLn "Failed to open GLFW window. If you have an Intel GPU, they are not 3.3 compatible. Try the 2.1 version of the tutorials."
