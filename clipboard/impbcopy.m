#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <unistd.h>
/**
  Instructions:

  Save this gist into a file called impbcopy.m under your 
      $PATH (e.g. /usr/local/bin).

  Compile it with:
      gcc -Wall -g -O3 -ObjC -framework Foundation -framework AppKit -o impbcopy impbcopy.m
  
  Now you should be able to run it with 
      impbcopy path/to/file.png

  This code courtesy of Alex Jacobson.
  https://gist.github.com/mwender/49609a18be41b45b2ae4
*/



BOOL copy_to_clipboard(NSString *path)
{
  // http://stackoverflow.com/questions/2681630/how-to-read-png-image-to-nsimage
  NSImage * image;
  if([path isEqualToString:@"-"])
  {
    // http://caiustheory.com/read-standard-input-using-objective-c 
    NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
    image = [[NSImage alloc] initWithData:[input readDataToEndOfFile]];
  }else
  { 
    image =  [[NSImage alloc] initWithContentsOfFile:path];
  }
  // http://stackoverflow.com/a/18124824/148668
  BOOL copied = false;
  if (image != nil)
  {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    NSArray *copiedObjects = [NSArray arrayWithObject:image];
    copied = [pasteboard writeObjects:copiedObjects];
    [pasteboard release];
  }
  [image release];
  return copied;
}

int main(int argc, char * const argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  if(argc<2)
  {
    printf("Usage:\n\n"
      "Copy file to clipboard:\n    ./impbcopy path/to/file\n\n"
      "Copy stdin to clipboard:\n    cat /path/to/file | ./impbcopy -");
    return EXIT_FAILURE;
  }
  NSString *path= [NSString stringWithUTF8String:argv[1]];
  BOOL success = copy_to_clipboard(path);
  [pool release];
  return (success?EXIT_SUCCESS:EXIT_FAILURE);
}