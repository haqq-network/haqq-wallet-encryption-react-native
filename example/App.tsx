/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, {useCallback, useState} from 'react';
import {
  Alert,
  Button,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import {decrypt, encrypt, passworder} from '@haqq/encryption-react-native';

function App(): JSX.Element {
  const [stringToEncrypt, setStringToEncrypt] = useState('');
  const [objectToDecrypt, setObjectToDecrypt] = useState('');
  const [password, setPassword] = useState('');
  const [decrypted, setDecrypted] = useState('');
  const [encrypted, setEncrypted] = useState('');
  const [passworderDecrypted, setPassworderDecrypted] = useState('');
  const [passworderEncrypted, setPassworderEncrypted] = useState('');

  const onPressPassworderDecrypt = useCallback(async () => {
    try {
      const result = await passworder.decrypt<any>(password, objectToDecrypt);
      setPassworderDecrypted(result);
    } catch (err) {
      if (err instanceof Error) {
        Alert.alert('decrypt error', err.message);
      }
    }
  }, [objectToDecrypt, password]);

  const onPressPassworderEncrypt = useCallback(async () => {
    try {
      const result = await passworder.encrypt<any>(password, stringToEncrypt);
      setPassworderEncrypted(result);
    } catch (err) {
      if (err instanceof Error) {
        Alert.alert('encrypt error', err.message);
      }
    }
  }, [stringToEncrypt, password]);

  const onPressPassworderDecryptedText = useCallback(() => {
    Clipboard.setString(passworderDecrypted);
  }, [passworderDecrypted]);

  const onPressPassworderEncryptedText = useCallback(() => {
    Clipboard.setString(passworderEncrypted);
  }, [passworderEncrypted]);

  const onPressDecrypt = useCallback(async () => {
    try {
      const result = await decrypt<any>(password, objectToDecrypt);
      setDecrypted(result);
    } catch (err) {
      if (err instanceof Error) {
        Alert.alert('decrypt error', err.message);
      }
    }
  }, [objectToDecrypt, password]);

  const onPressEncrypt = useCallback(async () => {
    try {
      const result = await encrypt<any>(password, stringToEncrypt);
      setEncrypted(result);
    } catch (err) {
      if (err instanceof Error) {
        Alert.alert('encrypt error', err.message);
      }
    }
  }, [stringToEncrypt, password]);

  const onPressDecryptedText = useCallback(() => {
    Clipboard.setString(decrypted);
  }, [decrypted]);

  const onPressEncryptedText = useCallback(() => {
    Clipboard.setString(encrypted);
  }, [encrypted]);

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.scroll}>
        <TextInput
          multiline
          style={styles.input}
          placeholder={'password'}
          value={password}
          onChangeText={setPassword}
        />
        <TextInput
          multiline
          style={styles.input}
          placeholder={'string to encrypt'}
          value={stringToEncrypt}
          onChangeText={setStringToEncrypt}
        />
        <TextInput
          multiline
          style={styles.input}
          placeholder={'object to decrypt'}
          value={objectToDecrypt}
          onChangeText={setObjectToDecrypt}
        />

        <Text style={styles.title}>Common functions</Text>
        <Button title="encrypt" onPress={onPressEncrypt}/>
        <Text style={styles.textValue} onPress={onPressEncryptedText}>
          Encrypted: {encrypted}
        </Text>
        <Button title="decrypt" onPress={onPressDecrypt}/>
        <Text style={styles.textValue} onPress={onPressDecryptedText}>
          Decrypted: {decrypted}
        </Text>

        <Text style={styles.title}>Passworder</Text>
        <Button title="encrypt" onPress={onPressPassworderEncrypt}/>
        <Text style={styles.textValue} onPress={onPressPassworderEncryptedText}>
          Encrypted: {passworderEncrypted}
        </Text>
        <Button title="decrypt" onPress={onPressPassworderDecrypt}/>
        <Text style={styles.textValue} onPress={onPressPassworderDecryptedText}>
          Decrypted: {passworderDecrypted}
        </Text>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  scroll: {
    flex: 1,
  },
  container: {
    marginHorizontal: 20,
    flex: 1,
  },
  title: {
    fontSize: 20,
    marginVertical: 10,
  },
  input: {
    backgroundColor: '#eee',
    marginVertical: 5,
    padding: 10,
    borderRadius: 8,
  },
  textValue: {
    marginTop: 5,
    marginBottom: 10,
  },
});

export default App;
