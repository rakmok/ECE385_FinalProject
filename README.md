# ECE385_FinalProject

Creators: Omkar Kulkarni and Hari Gopal

1. Idea and Overview

Our project will be a fully working videogame sequence, similar to a Donkey Kong game as well as a 2D shooter. The two players will be in a static mode on opposite corners of the screen, with a sort of maze in between them. Each player has a rifle with unlimited ammo that they can shoot off the maze and attempt to hit the other player on the other side. The rifles are allowed to rotate 360 degrees, so that the player has a good amount of freedom and understanding of where to shoot in order to reach their target. Additionally, each player has a shield (to guard against the other player’s bullets) that they can activate for a set amount of time, which requires time to recharge if successfully activated and used.

The halls of the maze change dynamically, which requires the players to think about when they need to shoot and at what angle. Throughout the maze, there will be certain obstacles that “void” the bullet and absorb it, such that it ceases to exist. This adds a bit more in terms of thinking about the trajectory of the bullet once the player shoots it, since said player must account for both the moving of the maze as well as the obstacles within.

We’ll be using on-chip memory for the background, while the foreground assets will be stored on registers free from the M9K blocks. The background will be static sans the occasional bullet that is traveling across it, while the foreground will include the maze assets that angle themselves as well as the obstacles that travel across the maze. The Verilog code will give most of the commands in relation to our background and how we load it, whereas the C code will deal with priority over the background in relation to the bullets, shields and rifles and our colors at those particular moments, since they would need to switch with the background based on where they are. We’ll need a keyboard, monitor and our FPGA, but otherwise, equipment will be simple. Additionally, we’ll be taking certain code from our labs 6.2 and 7 for the VGA controller and Color Mapper, since the VGA controller won’t change based on this project and the Color Mapper will need to be duplicated a couple times for both our foreground and background sprites/assets.

3. List of Features
   Our baseline features that we’d like to implement are the projectiles reflecting off the sides of the walls, the moving walls, and the rifles rotating at 360 degrees.

Baseline features:
Projectiles
-Interactions with walls and certain objects will be the most difficult thing with the bullets, but it is essential to the game regardless considering the whole point is a PVP experience. Reflecting off walls will most likely be the crux of the project, since more math will be needed than actual implementation.
-The walls will need to rotate across a certain amount of degrees that we haven’t specified yet, but we expect that it will be around 10-15 degrees so that the walls won’t clash.
-Lastly, we’d like to make sure that the rifles visually rotate so as to give the player an idea of where they are aiming the bullets.

Additional Features
Shields for the players could be an interesting concept, since they would have a recharge time and a one time use if called. However, this would add another interaction for the bullets and would also require another I/O with the keyboard.

4. Expected Difficulty
   We expect the baseline difficulty of this project to be a 6 because considering and implementing the angle calculations for the bouncing bullets with timing constraints will be a challenge as will creating the dynamic obstacles in the background (like having regions where the bullets disappear). If we are able to add additional features like constructing the shield and making the background obstacles more bizarre, we feel that the difficulty would go up another point to 7 because we’d have to further consider memory constraints in our background color mapper with randomly generated objects.

5. Proposed Timeline
   For the first week, we hope to instantiate our SoC with the color palettes, sprites, and general shapes of the background. During this week, we plan to create the whole structure of the project and work out any flaws in our baseline design. By the mid-project checkpoint, we hope to complete the generation of the background with the static players on their respective sides and have the projectile angles calculated. By the third week, we hope to add the dynamic background and “void” spaces (where the bullet disappears) as well as the projectile motion interface with the usb keyboard. By the last week, we hope to add our extra features like the player shields and work on generating more complex and bizarre background obstacles.
