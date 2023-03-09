using CommandLine;
using FreeImageAPI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace imageTools
{
    class Program
    {
        static void Main(string[] args)
        {
            var options = Parser.Default.ParseArguments<Options>(args);

            if (options.Value==null)
            {
                return;
            }

            var image = FreeImage.LoadEx(options.Value.Input); //FreeImage.Load(FREE_IMAGE_FORMAT.FIF_UNKNOWN, options.Value.Input, FREE_IMAGE_LOAD_FLAGS.JPEG_ACCURATE);
            if(options.Value.rot!=null)
            {
                var bitmap = FreeImage.ConvertTo32Bits(image);
                FreeImage.Unload(image);
                image = FreeImage.Rotate(bitmap, options.Value.rot??0 * -1);
                FreeImage.Unload(bitmap);
            }
            
            if(!FreeImage.Save(FREE_IMAGE_FORMAT.FIF_TARGA, image, options.Value.Output, FREE_IMAGE_SAVE_FLAGS.JPEG_OPTIMIZE))
            {
                Console.WriteLine("保存失败");
            }
            FreeImage.Unload(image);
        }
    }
}
