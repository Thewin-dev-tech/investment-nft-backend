import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { EncryptionService } from './encryption.service';
import { CreateEncryptionDto } from './dto/create-encryption.dto';
import { UpdateEncryptionDto } from './dto/update-encryption.dto';

@Controller('encryption')
export class EncryptionController {
  constructor(private readonly encryptionService: EncryptionService) {}

  @Post()
  create(@Body() createEncryptionDto: CreateEncryptionDto) {
    return this.encryptionService.create(createEncryptionDto);
  }

  @Get()
  findAll() {
    return this.encryptionService.findAll();
  }

  @Post("decode")
  decode(@Body() decodeBody: CreateEncryptionDto){
      
      try{
        let body :Record<string , string> = JSON.parse(JSON.stringify(decodeBody));
        return this.encryptionService.decode(body.cypher_text,body.key);
      }catch(e:any){
        return {message : "error"};
      }
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.encryptionService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateEncryptionDto: UpdateEncryptionDto) {
    return this.encryptionService.update(+id, updateEncryptionDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.encryptionService.remove(+id);
  }
}
