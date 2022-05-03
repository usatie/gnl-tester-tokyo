# How to use
1. Clone this repository to the root directory of your gnl repository.
2. Run the make command inside this repository.

## 1. Clone this repository
```
$ cd /path/to/your/gnl/directory
$ git clone https://github.com/usatie/gnl-tester-tokyo.git
$ cd gnl-tester-tokyo
```

- If you would like to clone this repository to somewhere else, you can. In that case, please run the make command like this.
```
$ make GNL_DIR=/path/to/your/gnl/dir
```

## 2. Test Mandatory functions
```
$ make all
```

<img width="873" alt="Screen Shot 2022-05-03 at 11 36 50" src="https://user-images.githubusercontent.com/7609060/166396823-59ccc02f-a4b8-47a0-9dd0-6b7a94961c10.png">

<img width="1046" alt="Screen Shot 2022-05-03 at 11 36 22" src="https://user-images.githubusercontent.com/7609060/166396833-d4d37ff5-3723-4943-b063-d941a9a10a5e.png">

## 3. Test Norminette & coding rules
```
$ make norm
```

# Thanks predecessors!
This project is inspired by these projects, and many cases are imported from them too. Thanks a lot!

- https://github.com/Tripouille/gnlTester
