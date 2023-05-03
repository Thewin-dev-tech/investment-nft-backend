import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { CustomerController } from './controllers/customer.controller';
import { CustomerService } from './services/customer.service';

@Module({
  imports: [],
  controllers: [AppController,CustomerController],
  providers: [AppService,CustomerService],
})
export class AppModule {}
