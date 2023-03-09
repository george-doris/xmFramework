using CommandLine;
using System.Collections.Generic;

namespace imageTools
{
     class Options
    {
        [Option('i', "input", Required = true, HelpText = "输入png文件.")]
        public string Input { get; set; }

        [Option('o', "output", Required = true, HelpText = "输出tga文件.")]
        public string Output { get; set; }

        [Option('r', "rotate", Required = false, Default = null, HelpText = "旋转角度.")]
        public int? rot { get; set; }
    }
}
