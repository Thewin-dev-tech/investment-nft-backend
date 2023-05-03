import { Injectable } from '@nestjs/common';

@Injectable()
export class CustomerService {
  index(): string {
    return 'Hello this is customer!';
  }

  
}
