import pygame as pg
from OpenGL.GL import *

import engine

class App:
    """
        Calls high level control functions (handle input, draw scene etc)
    """

    def __init__(self, name, w=800, h=600):

        pg.init()
        self.screenWidth = w
        self.screenHeight = h
        pg.display.gl_set_attribute(pg.GL_CONTEXT_MAJOR_VERSION, 4)
        pg.display.gl_set_attribute(pg.GL_CONTEXT_MINOR_VERSION, 3)
        pg.display.gl_set_attribute(pg.GL_CONTEXT_PROFILE_MASK,
                                    pg.GL_CONTEXT_PROFILE_CORE)
        pg.display.set_mode((self.screenWidth, self.screenHeight), pg.OPENGL|pg.DOUBLEBUF)
        self.graphicsEngine = engine.Engine(self.screenWidth, self.screenHeight, f'shaders/{name}.glsl')

        self.lastTime = pg.time.get_ticks()
        self.currentTime = 0
        self.numFrames = 0
        self.frameTime = 0
        self.lightCount = 0

        self.mainLoop()
    
    def mainLoop(self):

        running = True
        while (running):
            #events
            for event in pg.event.get():
                if (event.type == pg.QUIT):
                    running = False
                if (event.type == pg.KEYDOWN):
                    if (event.key == pg.K_ESCAPE):
                        running = False
            
            #render
            self.graphicsEngine.renderScene()

            #timing
            self.calculateFramerate()
        self.quit()
    
    def calculateFramerate(self):

        self.currentTime = pg.time.get_ticks()
        delta = self.currentTime - self.lastTime
        if (delta >= 1000):
            framerate = max(1,int(1000.0 * self.numFrames/delta))
            pg.display.set_caption(f"Running at {framerate} fps.")
            self.lastTime = self.currentTime
            self.numFrames = -1
            self.frameTime = float(1000.0 / max(1,framerate))
        self.numFrames += 1

    def quit(self):
        #self.graphicsEngine.destroy()
        pg.quit()


if __name__ == "__main__":
    width = 1600
    height = 1024
    myApp = App(name='fractals', w=width, h=height)
    myApp.quit()