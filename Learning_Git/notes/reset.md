# reset

```shell
# 将当前分支的 HEAD 重置到最新提交，并丢弃工作区和暂存区的所有更改
git reset --hard HEAD
```

```shell
# 将当前分支的 HEAD 重置到上一个提交，并丢弃工作区和暂存区的所有更改
git reset --hard HEAD^
```

```shell
# 将当前分支的 HEAD 重置到最新提交，但保留暂存区和工作区的更改
git reset --soft HEAD
```

```shell
# 将当前分支的 HEAD 重置到上一个提交，但保留暂存区和工作区的更改
git reset --soft HEAD^
```

```shell
# 将当前分支的 HEAD 重置到指定的版本号，保留工作区的更改，但清空暂存区
git reset --mixed 版本号
```
