# HDLGen

#### 介绍
HDLGen是一个HDL生成工具，支持在Verilog里内嵌Perl或Python script来帮助快速、高效地生成期望的设计，支持Perl或者Python的所有数据结构和语法，有若干内嵌函数来提高效率，也支持Perl的扩展API(Python API扩展目前还不支持)，通过内嵌script和API来减少手动工作、提高开发效率和降低出错几率。
本工具支持自动instance,自动信号生成(instance & logic)，自定义电路(模块生成)。
本工具可以实现EMACS veirlog-mode的所有功能，另外再支持正则表达式、IPXACT、XML、interface、JSON、Hash等输入，并且使用方法和感觉是写HDL而不是HLS或者DSL,无论从功能还是上手容易度都比商业的SOC集成工具更高效、快捷。

[github: HDLGen](https://github.com/WilsonChen003/HDLGen)

#### 工作流程
   不同级别的设计都可以采用本工具，使用有限的不同函数和输入/输出来提高工作效率，如下图所示：
![Working Flow](https://gitee.com/wilson_chen/HDLGen/raw/master/doc/WorkingFlow.PNG)

#### 软件架构

```
├── HDLGen.bin                # Tool binary for easy adopt
├── HDLGen.pl                 # Tool source code
├── plugins                   # Tool plugin funcitons in Perl module
├── test                      # Source design code for testing
    ├── cfg                     # JSON and XML for config
    ├── incr                    # necessary design files
├── doc                       # usage introduction 
```




#### 安装教程
* 可以直接使用无需安装,但是源码运行需要安装某些Perl Module:       
 Getopt<br>
 JSON<br>
 Text::Template<br>
 File::Basename<br>
 File::Find<br>
 Verilog::Netlist<br>
 XML::Simple<br>
 XML::SAX::Expat; *#this is strange as not used at all, but pp need it*<br>
 Dumper<br>
 Text::ParseWords<br>
 Term::ANSIColor<br>

* 本工具只在 Ubuntu 18.04.05 & 20.04.5 和 Perl-5.34上做过测试, 但是任何安装了Perl5的Linux系统上应该都可以运行；
* Python script 目前只支持 Python3没有python2.x            


#### 使用说明

1.  首先需要根据Linux Shell来设置 “HDLGEN_ROOT” 环境变量，否则工具会报错；<br>
    参见：setenv.sh
2.  然后即可直接运行script或可执行程序(.bin):<br>
    cd test;<br>
    ../HDLGen.pl -i NV_NVDLA_CMAC_CORE_mac.src 或<br>
    ../HDLGen.bin -i NV_NVDLA_CMAC_CORE_mac.src 或<br>
    ../HDLGen.pl -f ./src.list<br>

   获取帮助信息可以用 -usage:<br>
    HDLGen.pl -usage


#### 参与贡献
Wilson Chen


#### 特技

1. RTL组装和生成
   * 从RTL或IPCAXT或JSON以Verilog的方式直接Instance module；
   * 用正则表达式来匹配端口名字，做信号连接；
   * 自动产生Instance端口信号的定义(reg & wire)，宽度自动学习、生成； 
   * 自动产生logic(assign & always)的信号定义(不完美但是大多数情况下可用);
   * 识别并报警任何Instance模块上没有被真实使用的信号；
   * 用内嵌的Perl或者Python生成任何想要的code(strucure/for/generator)；

2. Interface使用和生成
   * 从 IPXACT,JSON,RTL,SV code, Hash数组, YAML(后续支持)读入interface；
   * 向任何Interface追加port/signal；
   * 从任何Interface移除port/signal；
   * 以简洁模式打印显示Interface信号(用于IPCAXT debug）;

3. IPXACT/JSON使用和生成
   * 读入标准IPXACT或JSON文件并新增Interface和Port；
   * 以简洁模式打印显示IPXACT内定义的所有interface( for debug )
   * 翻译IPXACT文件到JSON格式( for debug or integration)
   * 输出port/signal输出到JSON文件(for integratation )
   * 将当前顶层模块的名字/Interface/Ports输出到JSON文件(for integration)   
   * 将当前顶层模块输出到标准的IPXACT文件 ---已决定不支持
 
4. 功能逻辑产生
   * 用内嵌的函数生成特定电路或模块，并且可定制 
     * Clk, Reset, Fuse, Pmu, Fifo, Async-interface, Memories 等；
   * 通过标准输入增加、定制私有的逻辑或模块(in development)
     * 以Verilog, JSON, YAML, EXCEL等为config输入.
     * 以一个简单的函数调用来输出code；

基于上述功能，本工具可以高效、自由地生成一个IP 或SOC top，并且比商业的SOC集成工具更容易上手，更直观、简洁、高效，而学习成本基本为零。

#### 注意
功能强大的EMACS 或 VIM 的Verilog-mode 可以实现 自动Port,Reg/Wire, 和Instance, 但是对比有如下差异：
   *  EMACS/VIM大部分情况下采用GUI模式，本工具是batch mode,同时支持文件列表输入；
   *  EMACS/VIM支持正则表达式相对复杂（通过第三方文件)，本工具直接在源码里采用类似Verilog的方式输入、使用；
   *  EMACS/VIM没有对未被使用的端口信号报警；
   *  EMACS/VIM不支持IPXACT或JSON或Interface； 
   *  EMACS/VIM不支持内嵌 Perl/Python；
   *  EMACS/VIM不支持函数功能生成或者定制电路生成；

#### 源码和结果示例

  * **AutoDef Sample:**<br>	
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/AutoDef_Sample.PNG" width="500" height="500"/><br/>
													

  * **AutoInstSig Sample:**<br>
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/AutoInstSig_Sample.PNG" width="500" height="500"/><br/>


  * **AutoWarning Sample:**<br>
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/AutoWarning_Sample.PNG" width="500" height="500"/><br/>


  * **Verilog Instance Sample:**<br>
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/Instance_Sample.PNG" width="500" height="500"/><br/> 


  * **IPXACT Instance Sample:**<br>
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/IPXACT_Sample.PNG" width="300" height="300"/><br/>


  * **JSON Instance Sample:**<br>
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/JSON_Sample.PNG" width="400" height="500"/><br/>


  * **Design Template File Sample:**<br>
<img src="https://gitee.com/wilson_chen/HDLGen/raw/master/doc/Design_Template_Sample.PNG" width="500" height="500"/><br/>

#### 为什么要这个工具
   
&emsp;&emsp;对于任何拥有超过10年经验的ASIC或SOC工程师，我们有时可能会讨厌Verilog，因为Verilog HDL的语法太简单或太基础，它是寄存器传输级别的描述，我们不是在编写代码，我们确实在设计电路，这很酷，但有时我们会感到无聊，尤其是在实例化模块时、信号连接时、信号定义时、重复或相似电路、模块例化时。<br>
&emsp;&emsp;当看到System Verilog for design时我们万分高兴，因为某些语法比如structure、 for、generate等可以大大提高撰写时的效率，但是很不幸的是这些语法的使用会带来debug时的痛苦，因为EDA工具的支持度还远远不够；甚至在某些时候需要手动修改RTL或网表来绕过特定EDA从而给项目带来风险。 <br>
&emsp;&emsp;那么为了提高效率减少手动工作，我们又会尝试用script来生成某些结构化code或者做集成工作,包括用Perl、Python,甚至vim、emacs script。但是这些方法往往都跟HDL独立使用且很多时候需要手动操作，版本维护时如果有任何一次没有对齐就会给项目引入风险。 <br>
&emsp;&emsp;所以我们又会学习和尝试更新的语言，比如Chisel、SpinalHDL、MyHDL、PyHDL或PyGear。但是，当我们学习、尝试后，最终我们放弃了，因为它们是DSL，它们不是HDL！
DSL是全新的语言，DSL更像是一种高级软件语言，我们必须以新的风格编写代码，根本不是Verilog或HDL的设计思路。 <br>
&emsp;&emsp;我们会有疑问：一个项目放弃Verilog/HDL是否安全？对于经验丰富的工程师来说，使用非HDL代码放弃以前的技能和设计逻辑是否安全？学习一门新语言是容易还是友好？这门语言是否被广泛使用或接受、并且会长期发展？这门语言是否适合于IP、ASIC、SOC开发？有什么不同的方式来帮助我们吗？<br>
&emsp;&emsp;是的，我们有不同的方式！而且它易于使用、移植顺畅、无缝采用。<br>
&emsp;&emsp;本工具将支持您继续编写HDL，同时大大提高效率，并且学习曲线为零，在这里，命名为"HDLGen"。<br>
&emsp;&emsp;你的工作方式是继续编写Verilog/HDL代码，本工具可帮助您完成最无聊的任务：自动为wire或reg定义信号；自动Instance Module并且支持信号名转义和定义；使用正则表达式连接或更改信号；像HDL代码一样直接实例JSON和IPXACT/XML文件。如果有任何任务、逻辑、模块设计对HDL不够友好(如structure,generate和for，或其他各种高级功能)，那么你可以使用脚本语言包括Perl和Python，来产生你想要的任何代码，在HDL源文件的任何地方。<br>
&emsp;&emsp;本工具支持标准 AMBA 总线接口，本工具还支持您通过SystemVerilog，Verilog，IPXACT或XML，JSON或HASH哈希数组手动定义inteface。<br>
&emsp;&emsp;另外，如果有任何内部开发或累积的设计对你的设计很有帮助，则你可以将RTL模板放在此工具中，然后通过在HDL中一个简单的函数调用即可生成模块、功能逻辑，并且可以通过JSON文件传递任何实例化参数。<br>

   **最直观有效的设计是“所见即所得”**<br>
   **绝大多数情况下Verilog是最安全的设计**<br>
   **在系统级上parameter的使用需要万分谨慎**<br>



  **DSL is really cool**<br>
  **But Verilog is still the King**<br> 
  **Connection is what you need**<br> 
  **And Fexibility is really helpful**<br> 


#### 感谢
   * 感谢 NVIDIA 给我机会了解 Perl 可以如何強大地运作大型 ASIC 工厂；<br>
   * 感謝 NVIDIA 的 VIVA让我知道 Perl 可以如何让 Verilog 变得有趣和令人惊讶；<br> 
   * 感謝 NVIDIA 的开源 NVDLA 作为测试来源；<br> 


#### 备注
该工具是在2022年的上海的特殊春季期间从零开始开发的，
与英伟达直接有关的事情是：  
- 2个函数的名称(Instance,Connect)相同
- 开源NVDLA的几个HDL文件当作测试源

 
