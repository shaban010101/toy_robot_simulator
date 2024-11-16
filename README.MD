# Toy Robot Simulator

### Requirements
* Ruby version 3.2.2

### Setup
Run `bundle install` in a terminal

### Testing
Run `bundle exec rspec` in a terminal

### How to use
To use the simulator you will need a text file with the following commands each on new lines and always starting with the PLACE command

```
PLACE X,Y,F - Places the robot on a square using the X and Y coordinates provided all arguments are required.
MOVE - Moves the toy robot one unit forward in the direction it is facing.
LEFT - Rotates the robot 90 degrees to the left from where it is currently facing.
RIGHT - Rotates the robot 90 degrees to the right from where it is currently facing.
REPORT - Outputs the current coordinates and direction the robot is facing as X,Y,FACING
```
If a command is not recognised you will get this error `unrecognised command: MOVES on line 13`

#### Example text file

````
PLACE 0,0,NORTH
MOVE
REPORT
````

Once you have your text file you can run it like this in your terminal `./runner --file sample.text`

Which will give you an output like this

```
0,1,NORTH
0,0,WEST
3,3,NORTH
```

### Improvements
* Supporting multiple file formats to read
* Using a CLI interface to issue commands which is quite straight forward as the commands can be issued from the `OperationExecutor`,
as its the interface to the simulator.

### Design choices
I seperated the project into a `Simulator` which moved the robot on a sqaure and reported the results. 
I opted to store the coordinates on a two dimensional array as this best represented sqaure table and used `Matrix` to retrieve the results
An `OperationExecutor` which is an interface to execute commands on the simulator and can be extended to receive commands in other ways such as CLI.
A `FileReader` which reads a text file and executes commands on the `OperationExecutor`. Finally I put all the config into one class 
