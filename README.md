# FlappyPlus (Godot Project)

This is a simple Flappy Bird–style game built in the Godot 4 game engine with GDScript.  
It was created as part of a course assignment to demonstrate familiarity with Godot, scripting, and game design.

---

## 🎮 How to Play
- Press **Space** (or click/tap) to flap the bird upward.  
- Avoid the pipes — colliding with them (or the ground) causes a **loss**.  
- Passing through pipes increases your **score**.  
- Collect **shields** (blue bird pickups) for temporary protection.  
- Survive and reach the **win condition** (configurable in `GameState.gd`) to trigger the win screen.

---

## ✅ Features (Meets Assignment Specs)
- **Playable Character**  
  - The bird responds to three unique inputs: flap, start/restart, and shield pickup usage.  

- **Interactable Level**  
  - Pipes spawn dynamically and must be avoided.  
  - Shields spawn periodically and can be collected.  

- **Win/Lose Conditions**  
  - Collision with pipes/ground = **loss**.  
  - Survive long enough (or pass enough pipes) = **win**.  

- **GUI System**  
  - In-game **HUD** shows current score.  
  - **Game Over** and **Win** screens display last score.  
  - **Main Menu** allows starting/restarting the game.  

---

## ⭐ Extra Features
- Animated character (bird flaps).  
- Sound effects (jump, collision, background music).  
- Shields provide a power-up mechanic.  

---

## ⚠️ Academic Integrity & AI Acknowledgment
Parts of this project were developed with assistance from **OpenAI’s ChatGPT**.  
ChatGPT was used to:
- Debug Godot/GDScript errors.  
- Suggest implementations for background scrolling, power-ups, and HUD updates.  
- Provide boilerplate code for scene management.  

All AI-assisted code was reviewed, tested, and integrated by me, the developer.  
This README and the supporting documentation were also structured with ChatGPT’s help.  
Final implementation, debugging, and project structure are my own work.
