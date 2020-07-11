Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
    -- no need to update if animation is only one frame
    if #self.frames > 1 then
        self.timer = self.timer + dt
        if self.timer > self.interval then
            self.timer = self.timer % self.interval
            if currentAnimation == attackAnimation then
                self.currentFrame = self.currentFrame + 1       
            else
                self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
            end
        end
    end

    if self.currentFrame == table.getn(self.frames) + 1 and currentAnimation == attackAnimation then
        self.currentFrame = 1
      --  if characterDY == 0 then
      --  --    currentAnimation = movingAnimation
       -- else
            currentAnimation = jumpAnimation
       -- end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end