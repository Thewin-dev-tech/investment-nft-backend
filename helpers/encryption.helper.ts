import * as crypto from 'crypto';

export class CryptoHelper {

  key : string ; 

  constructor(){
    this.key = "1234567890123456";
  }

  decryptCiphertext(ciphertext: string): Record<string, string> {
    const key:string = this.key;

    console.log(`key->`,this.key);
    const ciphertextBuffer = Buffer.from(ciphertext, 'base64');
    const iv = ciphertextBuffer.slice(0, 16);
    const hmac = ciphertextBuffer.slice(16, 48);
    const ciphertextRaw = ciphertextBuffer.slice(48);

    const calculatedHmac = crypto
    .createHmac('sha256', key)
    .update(ciphertextRaw)
    .digest();

    if (!crypto.timingSafeEqual(hmac, calculatedHmac)) {
      throw new Error('HMAC verification failed. The ciphertext may have been tampered with.');
    }

    const decipher = crypto.createDecipheriv('aes-128-cbc', key, iv);
    let decrypted = decipher.update(ciphertextRaw, null, 'utf8');
    decrypted += decipher.final('utf8');

    const subtext = ':';
    const [citizenId, firstName, lastName, birthday, sex] = decrypted.split(subtext);

    return {
      'Citizen ID': citizenId,
      'First Name': firstName,
      'Last Name': lastName,
      'Birthday': birthday,
      'Sex': sex,
    };
  }
}       

const ciphertext:string = '4XUuupII9pW+BJL8+L8FYwXgE7ZWN1gv7LBuay6qOK3JYcgd8MHNf1rK5U44Pn6tMVVvr7zpkZSHV8x7zcn/n7b7niqwPoqH/h9WMdUbqzExHVcSwWn9UC2PiZ0lp3lN'; // Replace with your PHP-generated ciphertext

let cryp = new CryptoHelper();
console.log(cryp.decryptCiphertext(ciphertext));