import { Controller, Get, Post, Body,Query, Patch, Param, Delete, UsePipes, ValidationPipe } from '@nestjs/common';
import { EncryptionService } from './encryption.service';
import { CreateEncryptionDto } from './dto/create-encryption.dto';
import { UpdateEncryptionDto } from './dto/update-encryption.dto';
import { UtilityHelper } from 'helpers/utility.helper';

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

  @Get("decode/:token")
  @UsePipes(new ValidationPipe({transform : false}))
  decodeWithParam(@Param("token") token ){
      try{
        
        console.log("original param ---->",token);
        return this.encryptionService.decode(token);

      }catch(e:any){
        console.log(e.stack);
        return {message : "error"};
      }
  }

  @Get("decode")
  decodeWithQuery(@Query("token") token : string){
      try{
        
        console.log("original query ---->",token);
        return this.encryptionService.decode(token);

      }catch(e:any){
        console.log(e.stack);
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
