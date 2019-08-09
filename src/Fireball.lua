Fireball = Class{}

function Fireball:init(def)
    self.x = def.x
    self.y = def.y
    self.texture = def.texture
    self.width = def.width
    self.height = def.height
    self.frame = def.frame
    self.solid = def.solid
    self.onCollide = def.onCollide

    self.directionX = def.direction
    self.directionY = 'down'
    self.map = def.map

    self.dx = 128
    self.dy = 8

    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8},
        interval = 0.07
    }

    self.currentAnimation = self.animation
end

function Fireball:update(dt)
    if self.directionX == 'left' then
        self.x = self.x - self.dx * dt
    else
        self.x = self.x + self.dx * dt
    end   
    
    if self.directionY == 'down' then
        self.y = self.y + self.dy * dt
    else
        self.y = self.y - self.dy * dt
    end

    if self.directionX == 'left' then
        self:checkLeftCollisions(dt)
    else
        self:checkRightCollisions(dt)
    end

    if self.directionY == 'down' then
        self:checkBottomCollisions(dt)
    else
        self:checkTopCollisions(dt)
    end

    self.currentAnimation:update(dt)
end

function Fireball:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()], self.x, self.y)
end

function Fireball:checkLeftCollisions(dt)
    local tileTopLeft = self.map:pointToTile(self.x + 1, self.y + 1)
    local tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height - 1)

    if (tileTopLeft and tileBottomLeft) and (tileTopLeft:collidable() or tileBottomLeft:collidable()) then
        self.x = (tileTopLeft.x - 1) * TILE_SIZE + tileTopLeft.width - 1
        self.directionX = 'right'
    end
end

function Fireball:checkRightCollisions(dt)
    local tileTopRight = self.map:pointToTile(self.x + self.width - 1, self.y + 1)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    if (tileTopRight and tileBottomRight) and (tileTopRight:collidable() or tileBottomRight:collidable()) then
        self.x = (tileTopRight.x - 1) * TILE_SIZE - self.width
        self.directionX = 'left'
    end
end

function Fireball:checkBottomCollisions(dt)
    local tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height + 1)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height + 1)
    
    if (tileBottomLeft and tileBottomLeft) and (tileBottomLeft:collidable() or tileBottomLeft:collidable()) then
        self.y = (tileBottomLeft.y - 1) * 16 - self.height + 1 
        self.directionY = 'up'
    end
end

function Fireball:checkTopCollisions(dt)
    local tileTopLeft = self.map:pointToTile(self.x + 3, self.y - 1)
    local tileTopRight = self.map:pointToTile(self.x + self.width - 3, self.y - 1)

    if (tileTopRight and tileTopRight) and (tileTopRight:collidable() or tileTopRight:collidable()) then
        self.y = (tileTopLeft.y - 1) * 16 + tileTopLeft.height - 1
        self.directionX = 'down'
    end
end