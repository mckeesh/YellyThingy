#import "MyScene.h"

@interface MyScene ()
@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@end

@implementation MyScene

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t monsterCategory        =  0x1 << 1;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        NSLog(@"Size: %@", NSStringFromCGSize(size));
        
        
        self.backgroundColor = [SKColor colorWithRed:0.588 green:0.835 blue:0.941 alpha:1.0];
        

        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"fatunicornsmaller"];
        self.player.position = CGPointMake(self.player.size.width/2, self.frame.size.height/2);
        
        self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.player.size];
        self.player.physicsBody.dynamic = YES;
        self.player.physicsBody.categoryBitMask = monsterCategory;
        self.player.physicsBody.contactTestBitMask = projectileCategory;
        self.player.physicsBody.collisionBitMask = 0;
        
        
        [self addChild:self.player];
        
        self.physicsWorld.gravity = CGVectorMake(0,-25);
        self.physicsWorld.contactDelegate = self;
        
        [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(jump)
                                       userInfo:nil
                                        repeats:YES];
        
        }
    return self;
}

- (void)addMonster {
    
    // Create sprite
    SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"missilesmaller"];
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    projectile.physicsBody.contactTestBitMask = monsterCategory;
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    // Determine where to spawn the monster along the Y axis
    int minY = projectile.size.height / 2;
    int maxY = self.frame.size.height - projectile.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    projectile.position = CGPointMake(self.frame.size.width + projectile.size.width/2, actualY);
    [self addChild:projectile];
    
    // Determine speed of the monster
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(-projectile.size.width/2, actualY) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 1.5) {
        self.lastSpawnTimeInterval = 0;
        [self addMonster];
    }
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    NSLog(@"Hit");
    [projectile removeFromParent];
    [monster removeFromParent];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [self jump];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
 
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        NSLog(@"Missle hit. You dead.");
        [self.player removeFromParent];
    }
    
    //Your first body is the block, secondbody is the player.
    //Implement relevant code here.
    
}

-(void)jump
{
    double soundInputJump = abs([MicrophoneReciever buffervalue]);
    if(log(soundInputJump+1)*15 < 10){
        soundInputJump = 0;
    }
    self.player.physicsBody.velocity = CGVectorMake(0, log(soundInputJump+1)*50);
//    NSLog(@"%f", log(soundInputJump+1)*50);
}



@end
