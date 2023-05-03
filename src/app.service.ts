import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  getUsers() : any{
    const user :any = [{name : "thewin"},{name : "dargon"}];
    return user;
  }
}
