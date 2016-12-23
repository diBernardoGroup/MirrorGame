# MirrorGame
This code allows a user to play the mirror game with a virtual agent , controlled via either an adaptive or an optimal control strategy, through either a Mouse or a Leap motion.

For more details, see our paper “Design and Validation of a Virtual Player for Studying Interpersonal Coordination in the Mirror Game” by Chao Zhai, Francesco Alderisio, Piotr Slowinski, Krasimira Tsaneva-Atanasova and Mario di Bernardo, submitted to IEEE Transactions on Cybernetics.

A pre-print version is currently available at:

https://arxiv.org/abs/1509.05881


In order for the code to work properly, you first have to group the two subfolders provided (Adaptive control, Optimal control) into a main folder and name it as you wish. For the sake of simplicity, let us call it “IEEE_code”.

Then, make sure you add “IEEE_code” (with all its subfolders) to your Matlab path.

If you wish to use a Leap Motion controller (https://www.leapmotion.com/), please visit the following link:

https://github.com/jeffsp/matleap

and add relevant files to “IEEE_code”.


NOTE: the following code runs correctly on MATLAB_R2016a and newer versions. 


HOW TO USE “ADAPTIVE CONTROL”
In order to start a trial and interact with a virtual player controlled by an adaptive control strategy, all you have to do is call the function “main.m”.

- In order to change position and size of the plots you wish to visualise, please edit the files “setInterface.m” and “setPlots.m” accordingly.

- In order to correctly interact with the VP via a mouse, please make sure that the variable “mouseMax” in the file “parameters_MouseAndLM.m” contained in the subfolder “parameters” is equal to the maximum horizontal resolution of your display. It is possible to check this value by calling the function

C = get(0,'PointerLocation');

and check the value of C(1,1) after positioning your cursor at the extreme right of your screen.

- It is possible to choose the input device (mouse or leap motion) after calling the function “main.m”. Please enter [1] to use a Mouse, and [2] to use a leap motion.

- Parameters of the HKB equation and controller can be set within the function “parametersHC.m” in the subfolder “parameters”.



HOW TO USE “OPTIMAL CONTROL”
In order to start a trial and interact with a virtual player controlled by an optimal control strategy, all you have to do is call the function “main.m”.

- In order to change position and size of the plots you wish to visualise, please edit the files “setInterface.m” and “setPlots.m” accordingly.

- In order to correctly interact with the VP via a mouse, please make sure that the numerical value in the function “getLeaderPositionMouse.m” is equal to the maximum horizontal resolution of your display (1280 in our case). It is possible to check this value by calling the function

C = get(0,'PointerLocation');

and check the value of C(1,1) after positioning your cursor at the extreme right of your screen.

- It is possible to choose the input device (mouse or leap motion) after calling the function “main.m”. Please enter [1] to use a Mouse, and [2] to use a leap motion.

- Parameters of the HKB equation can be set within the function “main.m”, whereas the control parameters theta_p and theta_sigma can be set after calling the function “main.m”. The value of eta can also be changed in the function “main.m”.

- After calling the function “main.m”, 18 different control signatures (contained in the files “reference1.mat” and “reference2.mat”) can be chosen. However, it is possible to add any other trajectory to the code at will.
