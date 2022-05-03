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

## 3. Test Norminette & coding rules
```
$ make norm
```
