#import <Foundation/Foundation.h>

BOOL writeNSString(FILE *fp, NSString *string) {
    unichar *p = NULL;
    int length = 0;
    int stringLength = (int)[string length];

    // 文字列を書き出す
    //    if (!writeInt(fp, &stringLength)) {
    //        return NO;
    //    }

    // 保存先となる一時バッファを確保する
    p = (unichar*)malloc(sizeof(unichar) * stringLength);
    //    BIO_NULL_POINTOR_CHECK(p);

    // 一時バッファにNSStringをUTF-8にデコードしたバイナリ列をコピーする
    [string getCharacters:p];

    // 一時バッファのデータをファイルに書き出す．
    length = (int)fwrite(p, sizeof(unichar), stringLength, fp);
    free(p);

    // 正しく一時バッファの長さだけ書き出せたときにYESを返す．
    return (length == stringLength);
}
