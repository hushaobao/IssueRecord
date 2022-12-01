#### TensorRT  
  
```shell
# error info
[TensorRT] ERROR: engine.cpp (1036) - Cuda Error in executeInternal: 700 (an illegal memory access was encountered)  
[TensorRT] ERROR: FAILED_EXECUTION: std::exception

# 检查输出的维度是否正确（申请内存小了）
```

```shell
/usr/bin/ld: warning: libblas.so.3, needed by //usr/lib/libarmadillo.so.8, not found (try using -rpath or -rpath-link)
/usr/bin/ld: warning: liblapack.so.3, needed by //usr/lib/libarmadillo.so.8, not found (try using -rpath or -rpath-link)
//usr/lib/libarmadillo.so.8: undefined reference to `sgbsv_'
//usr/lib/libarmadillo.so.8: undefined reference to `zgemm_'
//usr/lib/libarmadillo.so.8: undefined reference to `sdot_'
//usr/lib/x86_64-linux-gnu/libarpack.so.2: undefined reference to `clahqr_'
//usr/lib/x86_64-linux-gnu/libarpack.so.2: undefined reference to `dorm2r_'

# add .so file path to Env Variable
```

```shell
TensorRT trt accuracy error analyse

https://elinux.org/TensorRT/LayerDumpAndAnalyze
https://elinux.org/TensorRT/How2Debug
https://elinux.org/TensorRT/AccuracyIssues
https://github.com/NVIDIA/TensorRT/issues/380

```


#### python

```python

# argparse parse error
# cur pyfile call another pyfile parse_args func
parse_known_args()
parse_args()
# give undefined param cause this error, 
# use parse_known_args replace parse_args() can solve
```
