import { Injectable } from '@nestjs/common';

@Injectable()
export class CustomerService {
  index(): string {
    return 'Hello this is customer!';
  }

  testPost() : any { 
    return JSON.stringify({name : "Lnw_za"});
  }

  
}
